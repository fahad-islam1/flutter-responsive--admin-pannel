// sold_item_database.dart

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import '../../model/item_model_db.dart';

class SoldItemDatabase {
  static Box<ItemModel>? _soldItemBox;

  static Future<void> init() async {
    if (_soldItemBox == null) {
      final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);
      // Check if the adapter is not registered before registering it
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(ItemModelAdapter());
      }
      _soldItemBox = await Hive.openBox<ItemModel>('sold_items');
    }
  }

  static Future<void> addSoldItem(ItemModel item) async {
    await init(); // Ensure that the box is initialized before adding items
    _soldItemBox!.add(item);
  }

  static Future<List<ItemModel>> getAllSoldItems() async {
    await init(); // Ensure that the box is initialized before getting items
    return _soldItemBox!.values.toList();
  }


  static Future<void> deleteSOldItem(ItemModel itemToDelete) async {
    await init(); // Ensure that the box is initialized before deleting items
    int index = _soldItemBox!.values.toList().indexWhere((item) => item.id == itemToDelete.id);
    if (index != -1) {
      await _soldItemBox!.deleteAt(index);
    }
  }


  static Future<void> clearAllSoldItems() async {
    await init(); // Ensure that the box is initialized before clearing items
    await _soldItemBox!.clear();
    print('Clear');
  }
}
