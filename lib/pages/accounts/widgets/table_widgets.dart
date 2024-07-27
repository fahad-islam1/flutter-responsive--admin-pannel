
import 'package:flutter/material.dart';

import '../../../db/hive/accounts_db.dart';

class CustomTable extends StatefulWidget {
  const CustomTable({Key? key}) : super(key: key);

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  final List<Map<String, String>> _items = [{}];
  final List<TextEditingController> _totalLoadControllers = [];
  final List<TextEditingController> _sendedLoadControllers = [];
  final List<TextEditingController> _remainingLoadControllers = [];

  @override
  void initState() {
    super.initState();
    _addItemRow();
  }

  void _addItemRow() {
    _totalLoadControllers.add(TextEditingController());
    _sendedLoadControllers.add(TextEditingController());
    _remainingLoadControllers.add(TextEditingController());
  }

  void _updateRow(int index) {
    setState(() {
      _items[index] = {
        'Total Load': _totalLoadControllers[index].text,
        'Sended Load': _sendedLoadControllers[index].text,
        'Remaining Load': _remainingLoadControllers[index].text,
      };
    });

    if (index == _items.length - 1) {
      _items.add({});
      _addItemRow();
    }

    HiveDatabase.addTableData([_items[index]]);
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      children: [
        TableRow(
          children: [
            const TableCell(child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Total Load'),
            )),
            const TableCell(child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Sended Load'),
            )),
            const TableCell(child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Remaining Load'),
            )),
            const TableCell(child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Actions'),
            )),
          ],
        ),
        for (var index = 0; index < _items.length; index++)
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _totalLoadControllers[index],
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _sendedLoadControllers[index],
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _remainingLoadControllers[index],
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _updateRow(index);
                    },
                    child: const Text('Update'),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}