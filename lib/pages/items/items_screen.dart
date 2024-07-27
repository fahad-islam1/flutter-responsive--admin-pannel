import 'package:flutter/material.dart';
import 'package:flutter_dashboard/pages/items/widgets/sold_item_table.dart';
import '../../Responsive.dart';
import '../../db/hive/item_db.dart';
import '../../db/hive/item_sale.dart';
import '../../model/health_model.dart';
import '../../model/item_model_db.dart';
import '../../widgets/alert_dialogue.dart';
import '../home/widgets/activity_details_card.dart';
import '../home/widgets/header_widget.dart';
import '../home/widgets/item_table.dart';

class ItemsScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ItemsScreen({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  List<ItemModel> _items = [];
  List<ItemModel> _soldItems = []; // List for storing sold items
  final List dashboardList = const [
    DetailsModel(icon: Icons.attach_money, value: "1000", title: "Total Item"),
    DetailsModel(icon: Icons.send, value: "500", title: "Total send"),
    DetailsModel(icon: Icons.get_app, value: "800", title: "Total get"),
    DetailsModel(
        icon: Icons.monetization_on, value: "1300", title: "Ending money"),
  ];

  @override
  void initState() {
    super.initState();
    _loadItems();
    _loadSoldItems(); // Load sold items
  }

  Future<void> _loadItems() async {
    await ItemDatabase.init();
    _items = await ItemDatabase.getAllItems();
    setState(() {});
  }

  Future<void> _loadSoldItems() async {
    await SoldItemDatabase.init(); // Initialize sold item database
    _soldItems = await SoldItemDatabase.getAllSoldItems();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              SizedBox(
                height: Responsive.isMobile(context) ? 5 : 18,
              ),
              Header(scaffoldKey: widget.scaffoldKey),
              SizedBox(height: Responsive.isMobile(context) ? 20 : 30),
              ActivityDetailsCard(healthDetails: dashboardList,),
              SizedBox(height: 30),
              _items.isEmpty
                  ? Text('No items added yet')
                  : ItemsTableWidget(
                items: _items,
                onUpdate: _updateItem,
                onDelete: _deleteItem, onSell:
                _sellItem

              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _showAddItemDialog(context);
                },
                child: Text('Add Item'),
              ),

              SizedBox(height: 30),
              _soldItems.isNotEmpty
                  ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sold Items', style: TextStyle(fontSize: 20)),
                      SizedBox(width: 18),
                      ElevatedButton(
                        onPressed: () async {
                          await SoldItemDatabase.clearAllSoldItems();
                          _loadSoldItems();

                          setState(() {
                          });
                        },
                        child: Text('Clear Sold Items'),
                      ),

                    ],
                  ),
                  SizedBox(height: 10),
                  SoldItemsTableWidget(soldItems: _soldItems, onDelete: _deleteSoldItem,),
                ],
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showAddItemDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddItemAlertDialog(
          onItemAdded: () {
            _loadItems();
          },
        );
      },
    );
  }



  Future<void> _updateItem(ItemModel updatedItem) async {
    try {
      // Update the item in the database
      await ItemDatabase.updateItem(updatedItem);

      // Find the index of the existing item in the local list
      final index = _items.indexWhere((item) => item.id == updatedItem.id);

      // If the item exists in the local list, update it and the UI
      if (index != -1) {
        setState(() {
          _items[index] = updatedItem;
        });
      } else {
        // If the item does not exist, show a snackbar message
        final snackBar = SnackBar(content: Text('Item not found.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      // Handle any exceptions that may occur during the update process
      print('Error updating item: $e');
      final snackBar = SnackBar(content: Text('Error updating item.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _sellItem(ItemModel itemToSell) async {
    try {
      // Check if the item quantity is greater than 0 before selling
      if (int.parse(itemToSell.quantity) > 0) {
        // Decrease the quantity of the item by one
        final updatedItem = itemToSell.copyWith(
          quantity: (int.parse(itemToSell.quantity) - 1).toString(),
        );

        // Update the item in the items database
        await ItemDatabase.updateItem(updatedItem);

        // Add the sold item to the sold items database using the updated quantity
        await SoldItemDatabase.addSoldItem(updatedItem.copyWith(quantity: "1"));

        // Reload the items and sold items list
        await _loadItems();
        await _loadSoldItems();
      } else {
        // If the item quantity is already 0, show a message
        final snackBar = SnackBar(content: Text('Item out of stock.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print('Error selling item: $e');
      final snackBar = SnackBar(content: Text('Error selling item.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }



  Future<void> _deleteItem(ItemModel itemToDelete) async {
    await ItemDatabase.deleteItem(itemToDelete);
    await _loadItems();
  }
  Future<void> _deleteSoldItem(ItemModel itemToDelete) async {
    await SoldItemDatabase.deleteSOldItem(itemToDelete);
    await _loadSoldItems();
    print('object');
  }
}
