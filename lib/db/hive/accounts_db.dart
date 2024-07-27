import 'package:flutter/cupertino.dart';
import 'package:flutter_dashboard/model/accounts_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:uuid/uuid.dart';

class HiveDatabase {
  static Box<AccountsData>? _account;

  // Initialize Hive and open the 'account' box
  // Initialize Hive and open the 'account' box
  static Future<void> init() async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    // Register adapter for AccountsData if not registered already
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(AccountsDataAdapter());
      _account = await Hive.openBox<AccountsData>('account');
      print('value');

    }

  }


    static Future<void> addTableData(List<Map<String, String>> tableData) async {
      await init();
      final uuid = Uuid();

      for (var data in tableData) {
        final uniqueId = uuid.v4();
        final accountsData = AccountsData(
          id: uniqueId,
          totalLoad: int.parse(data['Total Load']!),
          sendedLoad: int.parse(data['Sended Load']!),
          remainingLoad: int.parse(data['Remaining Load']!),
        );
        await _account?.add(accountsData).then((value) {
          print(value);
        });
      }
  }
  static Future<void> updateItem(AccountsData updatedItem) async {
    await init();
    await _account!.put(updatedItem.id, updatedItem);
  }

  static Future<void> deleteItem(AccountsData itemToDelete) async {
    await init();
    int index = _account!.values.toList().indexWhere((item) => item.id == itemToDelete.id);
    if (index != -1) {
      await _account!.deleteAt(index);
    }
  }

  static Future<List<AccountsData>> getAllItems() async {
    await init();
    return _account!.values.toList();
  }
}
