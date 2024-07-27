import 'package:flutter/material.dart';
import 'package:flutter_dashboard/Responsive.dart';
import 'package:flutter_dashboard/model/menu_modal.dart';
import 'package:flutter_dashboard/pages/accounts/balance_screen.dart';
import 'package:flutter_dashboard/pages/accounts/bank_transaction.dart';
import 'package:flutter_dashboard/pages/accounts/easy_pisa.dart';
import 'package:flutter_dashboard/pages/accounts/jazzcash.dart';
import 'package:flutter_dashboard/pages/home/home_page.dart';
import 'package:flutter_dashboard/pages/items/items_screen.dart';
import 'package:flutter_dashboard/profile/profile.dart';

class Menu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function(int, String) onMenuItemSelected; // Callback function

  const Menu({Key? key, required this.scaffoldKey, required this.onMenuItemSelected});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<MenuModel> menu = [
    MenuModel(
        icon: Icons.home, title: "Shop Software", iconColor: Colors.white54),
    MenuModel(icon: Icons.calendar_today,
        title: "Items",
        iconColor: Colors.redAccent),
    MenuModel(icon: Icons.local_atm_sharp,
        title: "JazzCash",
        iconColor: Colors.green),
    MenuModel(icon: Icons.money, title: "EasyPisa", iconColor: Colors.blue),
    MenuModel(icon: Icons.local_atm_sharp,
        title: "Bank Transaction",
        iconColor: Colors.blue),
    MenuModel(icon: Icons.money, title: "Balance", iconColor: Colors.pink),
    MenuModel(icon: Icons.person, title: "Profile", iconColor: Colors.black54),
    MenuModel(icon: Icons.logout, title: "Signout", iconColor: Colors.black54),
  ];
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey[800]!,
            width: 1,
          ),
        ),
        color: const Color(0xFF171821),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Responsive.isMobile(context) ? 40 : 80,
              ),
              for (var i = 0; i < menu.length; i++)
                Column(
                  children: [
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6.0),
                        ),
                        color: selected == i
                            ? Theme
                            .of(context)
                            .primaryColor
                            : Colors.transparent,
                      ),
                      child: InkWell(
                        onTap: () {

                            setState(() {
                              selected = i;

                              widget.onMenuItemSelected(
                                  i, menu[i].title); // Notify parent widget
                              widget.scaffoldKey.currentState!.closeDrawer();
                            });
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 7),
                              child: Icon(
                                menu[i].icon,
                                color: selected == i ? Colors.black : Colors
                                    .grey,
                              ),
                            ),
                            Text(
                              menu[i].title,
                              style: TextStyle(
                                fontSize: 16,
                                color: selected == i ? Colors.black : Colors
                                    .grey,
                                fontWeight: selected == i
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // Add button to add banks below "Shop Software" menu item
                    if (i == 0)
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                          color: Colors.transparent,
                        ),
                        child: InkWell(
                          onTap: _addBanks,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 13, vertical: 7),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                'Add Banks',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
  //
  // void _addNewMenuItem() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       String newMenuItemTitle = ''; // Variable to store the new menu item title
  //       return AlertDialog(
  //         title: Text('Enter New Menu Item Title'),
  //         content: TextField(
  //           onChanged: (value) {
  //             setState(() {
  //               newMenuItemTitle = value;
  //             });
  //           },
  //           decoration: InputDecoration(hintText: 'Enter Title'),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               setState(() {
  //                 // Add the new menu item
  //                 menu.add(MenuModel(
  //                   icon: Icons.menu, // Add your desired icon
  //                   title: newMenuItemTitle,
  //                   iconColor: Colors.grey, // Add your desired color
  //                 ));
  //               });
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Add'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _addBanks() {
    showDialog(
      context: context,
      builder: (context) {
        String newBankTitle = ''; // Variable to store the new bank title
        return AlertDialog(
          title: Text('Add Bank'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                newBankTitle = value;
              });
            },
            decoration: InputDecoration(hintText: 'Enter Bank Title'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  // Add the new bank menu item
                  menu.insert(
                    8, // Index where you want to insert the bank menu item
                    MenuModel(
                      icon: Icons.account_balance, // Add your desired icon
                      title: newBankTitle,
                      iconColor: Colors.grey, // Add your desired color
                    ),
                  );
                });
                Navigator.of(context).pop();

                // Pass the bank name to AddedBanks widget
                widget.onMenuItemSelected(8, newBankTitle);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

}
