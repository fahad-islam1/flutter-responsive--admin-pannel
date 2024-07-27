
// SoldItemsTableWidget
import 'package:flutter/material.dart';

import '../../../model/item_model_db.dart';

class SoldItemsTableWidget extends StatelessWidget {
  final List<ItemModel> soldItems;
  final Function(ItemModel) onDelete; // Callback function for delete action


  const SoldItemsTableWidget({Key? key, required this.soldItems, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('Item Name')),
          DataColumn(label: Text('Cost Price')),
          DataColumn(label: Text('Sale Price')),
          // DataColumn(label: Text('Item ID')),
          DataColumn(label: Text('Item Quantity')),
          DataColumn(label: Text('Actions')),

        ],
        rows: soldItems.map((item) {
          return DataRow(cells: [
            DataCell(Text(item.title)),
            DataCell(Text(item.costPrice)),
            DataCell(Text(item.salePrice)),
            // DataCell(Text(item.id)),
            DataCell(Text(item.quantity)),
            DataCell(
              ElevatedButton(
                onPressed: () {
                  onDelete(item);
                },
                child: Text('Delete'),
              ),
            ),
          ]);
        }).toList(),
      ),
    );
  }


}
