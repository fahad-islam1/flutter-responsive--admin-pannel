// add_item_alert_dialog.dart

import 'package:flutter/material.dart';
import '../db/hive/item_db.dart';
import '../model/item_model_db.dart';

class AddItemAlertDialog extends StatefulWidget {
  final Function() onItemAdded;

  const AddItemAlertDialog({Key? key, required this.onItemAdded}) : super(key: key);

  @override
  _AddItemAlertDialogState createState() => _AddItemAlertDialogState();
}

class _AddItemAlertDialogState extends State<AddItemAlertDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _costPriceController = TextEditingController();
  final TextEditingController _salePriceController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Item'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Item Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter item name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _costPriceController,
                decoration: InputDecoration(labelText: 'Cost Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Cost price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _salePriceController,
                decoration: InputDecoration(labelText: 'Sell Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Sell price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'Item ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter item ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Item Quantity'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter item quantity';
                  }
                  return null;
                },
              ),
            ],
          ),
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
            if (_formKey.currentState!.validate()) {
              final newItem = ItemModel(
                title: _titleController.text,
                costPrice: _costPriceController.text,
                salePrice: _salePriceController.text,
                id: _idController.text,
                quantity: _quantityController.text,
              );
              ItemDatabase.addItem(newItem);
              widget.onItemAdded();
              Navigator.of(context).pop();
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
