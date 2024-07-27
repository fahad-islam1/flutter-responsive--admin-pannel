import 'package:flutter/material.dart';
import 'package:flutter_dashboard/profile/widgets/custom_text_field.dart';
import 'package:flutter_dashboard/responsive.dart';
import 'package:flutter_dashboard/const.dart';


import '../../pages/home/widgets/header_widget.dart';
import '../widgets/custom_buttons.dart';


class Profile extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const Profile({super.key, required this.scaffoldKey});

  @override
  State<Profile> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<Profile> {


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
              // SizedBox(
              //   height: Responsive.isMobile(context) ? 5 : 18,
              // ),
              SizedBox(
                height: Responsive.isMobile(context) ? 5 : 100,
              ),
              Image.asset(
                "assets/images/avatar.png",
              ),
              const Text(
                "Summer",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 2,
              ),

              SizedBox(height: Responsive.isMobile(context) ? 20 : 30),
              CustomTextField(hintText: 'Name', prefixIcon: Icons.people,),
              SizedBox(height: Responsive.isMobile(context) ? 20 : 30),

              CustomTextField(hintText: 'Email', prefixIcon: Icons.email,),
              SizedBox(height: Responsive.isMobile(context) ? 20 : 30),

              CustomTextField(hintText: 'Current Password', prefixIcon: Icons.lock,),


              SizedBox(height: Responsive.isMobile(context) ? 20 : 30),
              ResponsiveButton(title: 'Save', onTap: () {  }, color: Theme.of(context).primaryColor,),
              SizedBox(height: Responsive.isMobile(context) ? 20 : 30),
            ],
          ),
        ),
      ),
    );
  }
}