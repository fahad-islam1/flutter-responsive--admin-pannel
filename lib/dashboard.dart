import 'package:flutter/material.dart';
import 'package:flutter_dashboard/Responsive.dart';
import 'package:flutter_dashboard/model/menu_modal.dart';
import 'package:flutter_dashboard/pages/accounts/added_banks.dart';
import 'package:flutter_dashboard/pages/accounts/balance_screen.dart';
import 'package:flutter_dashboard/pages/accounts/bank_transaction.dart';
import 'package:flutter_dashboard/pages/accounts/easy_pisa.dart';
import 'package:flutter_dashboard/pages/accounts/jazzcash.dart';
import 'package:flutter_dashboard/pages/home/home_page.dart';
import 'package:flutter_dashboard/pages/items/items_screen.dart';
import 'package:flutter_dashboard/profile/profile.dart';
import 'package:flutter_dashboard/widgets/menu.dart';
import 'package:flutter_dashboard/Responsive.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int selectedIndex = 0;
  String selectedBankName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: !Responsive.isDesktop(context)
          ? SizedBox(
        width: 250,
        child: Menu(
          scaffoldKey: _scaffoldKey,
          onMenuItemSelected: _onMenuItemSelected,
        ),
      )
          : null,
      endDrawer: Responsive.isMobile(context)
          ? SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child:  Profile(scaffoldKey: _scaffoldKey),
      )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Menu(
                    scaffoldKey: _scaffoldKey,
                    onMenuItemSelected: _onMenuItemSelected,
                  ),
                ),
              ),
            Expanded(
              flex: 8,
              child: getContent(selectedIndex),
            ),
          ],
        ),
      ),
    );
  }

  Widget getContent(int index) {
    switch (index) {
      case 0:
        return HomePage(scaffoldKey: _scaffoldKey);
    // Add cases for other menu items and their respective content widgets
      case 1:
        return ItemsScreen(scaffoldKey: _scaffoldKey);
      case 2:
        return JazzCashScreen(scaffoldKey: _scaffoldKey);
      case 3:
        return EasyPisa(scaffoldKey: _scaffoldKey);
      case 4:
        return BankTranscation(scaffoldKey: _scaffoldKey);
      case 5:
        return BalanceScreen(scaffoldKey: _scaffoldKey);

      case 6:
        return Profile(scaffoldKey: _scaffoldKey);


      case 8:
        return AddedBanks(scaffoldKey: _scaffoldKey, selectedBankName: selectedBankName);
      case 9:
        return AddedBanks(scaffoldKey: _scaffoldKey, selectedBankName: selectedBankName);
        case 10:
      return AddedBanks(scaffoldKey: _scaffoldKey, selectedBankName: selectedBankName);
      case 11:
      return AddedBanks(scaffoldKey: _scaffoldKey, selectedBankName: selectedBankName);

      case 12:
        return AddedBanks(scaffoldKey: _scaffoldKey, selectedBankName: selectedBankName);
      default:
        return Container(
          alignment: Alignment.center,
          child: Text("Content for menu item $index"),
        );
    }
  }

  void _onMenuItemSelected(int index, String bankName) {
    setState(() {
      selectedIndex = index;
    });

    // Pass the bank name to the AddedBanks widget
    setState(() {
      selectedBankName = bankName;
    });
  }
}
