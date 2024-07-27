// import 'package:flutter/material.dart';
//
//
// class AddLoadAlertDialog extends StatefulWidget {
//   final Function(Map<String, String>) onAddItem;
//
//   const AddLoadAlertDialog({required this.onAddItem});
//
//
//   @override
//   _AddLoadAlertDialogState createState() => _AddLoadAlertDialogState();
// }
//
// class _AddLoadAlertDialogState extends State<AddLoadAlertDialog> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _loadController = TextEditingController();
//   // final TextEditingController _priceController = TextEditingController();
//   // final TextEditingController _idController = TextEditingController();
//   // final TextEditingController _quantityController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Add Load'),
//       content: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 keyboardType: TextInputType.number,
//                 controller: _loadController,
//                 decoration: InputDecoration(labelText: 'Load'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter Load Amount';
//                   }
//                   return null;
//                 },
//               ),
//
//             ],
//           ),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             if (_formKey.currentState!.validate()) {
//               final newItem = {
//                 'Load': _loadController.text,
//
//               };
//               widget.onAddItem(newItem);
//               Navigator.of(context).pop();
//             }
//           },
//           child: Text('Add'),
//         ),
//       ],
//     );
//   }
// }
//
