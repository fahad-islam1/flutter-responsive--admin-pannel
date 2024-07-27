// items_table_widget.dart

import 'package:flutter/material.dart';
import '../../../model/item_model_db.dart';

class ItemsTableWidget extends StatelessWidget {
  final List<ItemModel> items;
  final Function(ItemModel) onUpdate; // Callback function for update action
  final Function(ItemModel) onDelete; // Callback function for delete action
  final Function(ItemModel) onSell;
  const ItemsTableWidget({
    Key? key,
    required this.items,
    required this.onUpdate,
    required this.onDelete, required this.onSell,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          // DataColumn(label: Text('Item ID')),

          DataColumn(label: Text('Item Name')),
          DataColumn(label: Text('Cost Price')),
          DataColumn(label: Text('Sale Price')),
          DataColumn(label: Text('Item Quantity')),
          DataColumn(label: Text('Actions')),
        ],
        rows: items.map((item) {
          return DataRow(cells: [
            // DataCell(Text(item.id)),

            DataCell(Text(item.title)),
            DataCell(Text(item.costPrice)),
            DataCell(Text(item.salePrice)),
            DataCell(Text(item.quantity)),
            DataCell(
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _showUpdateDialog(context, item); // Show update dialog
                    },
                    child: Text('Update'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      onDelete(item); // Call the onDelete callback
                    },
                    child: Text('Delete'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      onSell(item);
                    },
                    child: Text('Sell'),
                  ),
                ],
              ),
            ),
          ]);
        }).toList(),
      ),
    );
  }

  // Function to show the update dialog
  void _showUpdateDialog(BuildContext context, ItemModel item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _titleController = TextEditingController(text: item.title);
        final TextEditingController _costPriceController = TextEditingController(text: item.costPrice);
        final TextEditingController _salePriceController = TextEditingController(text: item.salePrice);
        final TextEditingController _idController = TextEditingController(text: item.id);
        final TextEditingController _quantityController = TextEditingController(text: item.quantity);

        return AlertDialog(
          title: Text('Update Item'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Item Name'),
                ),
                TextFormField(
                  controller: _costPriceController,
                  decoration: InputDecoration(labelText: 'Cost Price'),
                ),
                TextFormField(
                  controller: _salePriceController,
                  decoration: InputDecoration(labelText: 'Sale Price'),
                ),
                TextFormField(
                  controller: _idController,
                  decoration: InputDecoration(labelText: 'Item ID'),
                ),
                TextFormField(
                  controller: _quantityController,
                  decoration: InputDecoration(labelText: 'Item Quantity'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Update item with new values
                final updatedItem = ItemModel(
                  title: _titleController.text,
                  costPrice: _costPriceController.text,
                  salePrice: _salePriceController.text,
                  id: _idController.text,
                  quantity: _quantityController.text,
                );
                onUpdate(updatedItem); // Call the onUpdate callback
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
