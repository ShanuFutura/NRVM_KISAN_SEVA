import 'package:farmers_app/screens/home_page.dart';
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
      },
    );
  }
}
