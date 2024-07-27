import 'package:flutter/material.dart';
import 'package:flutter_dashboard/pages/accounts/widgets/add_dialoguebox.dart';
import 'package:flutter_dashboard/pages/accounts/widgets/table_widgets.dart';
import 'package:flutter_dashboard/widgets/alert_dialogue.dart';

import '../../Responsive.dart';
import '../../model/health_model.dart';
import '../../widgets/custom_card.dart';
import '../home/widgets/activity_details_card.dart';
import '../home/widgets/header_widget.dart';
import '../home/widgets/item_table.dart';

class BalanceScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const BalanceScreen({super.key, required this.scaffoldKey});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {


  final List dashboardList = const [
    DetailsModel(icon: Icons.attach_money, value: "1000", title: "Total Item"),
    DetailsModel(icon: Icons.send, value: "500", title: "Total send"),
    DetailsModel(icon: Icons.get_app, value: "800", title: "Total get"),
    DetailsModel(
        icon: Icons.monetization_on, value: "1300", title: "Ending money"),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Responsive.isMobile(context) ? 15 : 18),
          child: Column(
            children: [
              SizedBox(
                height: Responsive.isMobile(context) ? 5 : 18,
              ),
              Header(scaffoldKey: widget.scaffoldKey),
              SizedBox(height: Responsive.isMobile(context) ? 20 : 30),
              ActivityDetailsCard(healthDetails: dashboardList,),
              SizedBox(height: Responsive.isMobile(context) ? 20 : 30),
              Text('Balance', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
              SizedBox(height: Responsive.isMobile(context) ? 20 : 30),
              // CustomTable()

            ],
          ),
        ),
      ),
    );
  }


}


