import 'package:farmers_app/providers/http_providers.dart';
import 'package:farmers_app/screens/admin_notifications.dart';
import 'package:farmers_app/screens/crop_view.dart';
import 'package:farmers_app/screens/faq_list.dart';
// import 'package:farmers_app/screens/fertilizers_list_screen.dart';
import 'package:farmers_app/screens/fertilizers_view.dart';
import 'package:farmers_app/screens/home_page.dart';
import 'package:farmers_app/screens/loading_screen.dart';
import 'package:farmers_app/screens/machinary_list_screen.dart';
import 'package:farmers_app/screens/machines_view.dart';
import 'package:farmers_app/screens/pesticides_and_fertilizers_list.dart';
import 'package:farmers_app/screens/profile_edit_screen.dart';
import 'package:farmers_app/screens/registration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MainClass());

class MainClass extends StatelessWidget {
  const MainClass({Key? key}) : super(key: key);

  Future<bool> rememberUser() async {
    final pref = await SharedPreferences.getInstance();
    print((pref.getBool('isLogged')) ?? false.toString());
    return (pref.getBool('isLogged')) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => HttpProviders()),
      child: MaterialApp(
        theme: ThemeData(
            androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
            primarySwatch: Colors.teal),
        home: FutureBuilder(
          future: rememberUser(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            } else if (snap.connectionState == ConnectionState.done) {
              if (snap.data as bool) {
                // Provider.of<HttpProviders>(context).weather();
                return HomePage();
              } else {
                return Registration();
              }
            } else {
              return LoadingScreen();
            }
          },
        ),
        routes: {
          HomePage.routeName: (context) => HomePage(),
          Registration.routeName: (context) => Registration(),
          ProfileEditScreen.routeName: (context) => ProfileEditScreen(),
          CropView.routeName: (context) => CropView(),
          // FertilizersListScreen.routeName: (context) => FertilizersListScreen(),
          MachinaryListScreen.routeName: (context) => MachinaryListScreen(),
          FertilizersView.routeName: (context) => FertilizersView(),
          MachinesView.routeName: (context) => MachinesView(),
          FAQList.routeName: (context) => FAQList(),
          AdminNotifications.routeName: (context) => AdminNotifications(),
          PesticidesAndFertilizersList.routeName: (context) =>
              PesticidesAndFertilizersList(),
        },
      ),
    );
  }
}
