import 'package:farmers_app/screens/admin_notifications.dart';
import 'package:farmers_app/screens/crop_view.dart';
import 'package:farmers_app/screens/faq_list.dart';
import 'package:farmers_app/screens/fertilizers_list_screen.dart';
import 'package:farmers_app/screens/fertilizers_view.dart';
import 'package:farmers_app/screens/home_page.dart';
import 'package:farmers_app/screens/machinary_list_screen.dart';
import 'package:farmers_app/screens/machines_view.dart';
import 'package:farmers_app/screens/profile_edit_screen.dart';
import 'package:farmers_app/screens/registration.dart';
import 'package:flutter/material.dart';

void main() => runApp(MainClass());

class MainClass extends StatelessWidget {
  const MainClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Registration(),
      routes: {
        HomePage.routeName: (context) => HomePage(),
        Registration.routeName: (context) => Registration(),
        ProfileEditScreen.routeName: (context) => ProfileEditScreen(),
        CropView.routeName: (context) => CropView(),
        FertilizersListScreen.routeName: (context) => FertilizersListScreen(),
        MachinaryListScreen.routeName: (context) => MachinaryListScreen(),
        FertilizersView.routeName: (context) => FertilizersView(),
        MachinesView.routeName: (context) => MachinesView(),
        FAQList.routeName: (context) => FAQList(),
        AdminNotifications.routeName: (context) => AdminNotifications(),
      },
    );
  }
}
