import 'package:farmers_app/providers/http_providers.dart';
import 'package:farmers_app/screens/admin_notifications.dart';
import 'package:farmers_app/screens/crop_view.dart';
import 'package:farmers_app/screens/faq_list.dart';
import 'package:farmers_app/screens/feedback_screen.dart';

// import 'package:farmers_app/screens/fertilizers_view.dart';
import 'package:farmers_app/screens/home_page.dart';
import 'package:farmers_app/screens/loading_screen.dart';
import 'package:farmers_app/screens/machinary_list_screen.dart';
import 'package:farmers_app/screens/machine_request_status.dart';
import 'package:farmers_app/screens/machines_view.dart';
import 'package:farmers_app/screens/pesticides_and_fertilizers_list.dart';
import 'package:farmers_app/screens/profile_edit_screen.dart';
import 'package:farmers_app/screens/registration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tflite/tflite.dart';


  void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  print(await Tflite.loadModel(
    model: 'assets/MLKit/plant_disease_model.tflite',
    labels: 'assets/MLKit/plant_labels.txt',
  ));
  runApp(MainClass());}

class MainClass extends StatelessWidget {
  const MainClass({Key? key}) : super(key: key);

  Future<bool> rememberUser() async {
    final pref = await SharedPreferences.getInstance();
    // print((pref.getBool('isLogged')) ?? false.toString());
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
              return const LoadingScreen();
            } else if (snap.connectionState == ConnectionState.done) {
              if (snap.data as bool) {
                Provider.of<HttpProviders>(context).getSensorData();
                Provider.of<HttpProviders>(context).getConnectivityStatus();

                return const HomePage();
              } else {
                // return const HomePage();
                return Registration();
              }
            } else {
              return const LoadingScreen();
            }
          },
        ),
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          Registration.routeName: (context) => Registration(),
          ProfileEditScreen.routeName: (context) => ProfileEditScreen(),
          CropView.routeName: (context) => CropView(),
          MachinaryListScreen.routeName: (context) =>
              const MachinaryListScreen(),
          // FertilizersView.routeName: (context) => FertilizersView(),
          MachinesView.routeName: (context) => MachinesView(),
          FAQList.routeName: (context) => const FAQList(),
          AdminNotifications.routeName: (context) => const AdminNotifications(),
          PesticidesAndFertilizersList.routeName: (context) =>
              const PesticidesAndFertilizersList(),
          MachineRequestStatus.routeName: (context) => MachineRequestStatus(),
          FeedBackScreen.routeName: (context) => FeedBackScreen(),
        },
      ),
    );
  }
}
