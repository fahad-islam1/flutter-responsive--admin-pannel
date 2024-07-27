import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:uuid/uuid.dart'; // Import the uuid package
import '../../model/item_model_db.dart';

class ItemDatabase {
  static Box<ItemModel>? _itemBox;

  static Future<void> init() async {
    if (_itemBox == null) {
      final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);
      // Check if the adapter is not registered before registering it
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(ItemModelAdapter());
      }
      _itemBox = await Hive.openBox<ItemModel>('items');
    }
  }

  static Future<void> addItem(ItemModel item) async {
    await init(); // Ensure that the box is initialized before adding items
    final uuid = Uuid();
    final uniqueId = uuid.v4(); // Generate a unique ID using UUID
    final itemWithUniqueId = item.copyWith(id: uniqueId); // Assign the unique ID to the item
    _itemBox!.add(itemWithUniqueId); // Add the item to the database
  }

  static Future<void> updateItem(ItemModel updatedItem) async {
    await init(); // Ensure that the box is initialized before updating items
    print(updatedItem.id);
    await _itemBox!.put(updatedItem.id, updatedItem); // Update the item directly
    print('Updated');
    //
    // if (_itemBox!.containsKey(updatedItem.id)) {
    //   print('Updated');
    // } else {
    //   print('Item with ID ${updatedItem.id} not found in database.');
    //   // You can choose to handle this scenario differently,
    //   // such as showing a message to the user.
    // }
  }


  static Future<void> deleteItem(ItemModel itemToDelete) async {
    await init(); // Ensure that the box is initialized before deleting items
    int index = _itemBox!.values.toList().indexWhere((item) => item.id == itemToDelete.id);
    if (index != -1) {
      await _itemBox!.deleteAt(index);
    }
  }

  static Future<List<ItemModel>> getAllItems() async {
    await init(); // Ensure that the box is initialized before getting items
    return _itemBox!.values.toList();
  }
}
