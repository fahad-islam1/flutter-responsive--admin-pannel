import 'package:flutter/material.dart';
import 'package:flutter_dashboard/pages/home/widgets/header_widget.dart';
import 'package:flutter_dashboard/pages/home/widgets/item_table.dart';
import 'package:flutter_dashboard/responsive.dart';
import 'package:flutter_dashboard/pages/home/widgets/activity_details_card.dart';
import 'package:flutter_dashboard/widgets/alert_dialogue.dart';
import 'package:flutter_dashboard/widgets/custom_card.dart';

import '../../model/health_model.dart';


class HomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HomePage({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List dashboardList = const [
    DetailsModel(icon: Icons.attach_money, value: "1000", title: "Start money"),
    DetailsModel(icon: Icons.send, value: "500", title: "Total send"),
    DetailsModel(icon: Icons.get_app, value: "800", title: "Total get"),
    DetailsModel(icon: Icons.monetization_on, value: "1300", title: "Ending money"),
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


            ],
          ),
        ),
      ),
    );
  }


}