import 'package:farmers_app/providers/http_providers.dart';
import 'package:farmers_app/screens/admin_notifications.dart';
import 'package:farmers_app/screens/faq_list.dart';
import 'package:farmers_app/screens/feedback_screen.dart';

import 'package:farmers_app/screens/machinary_list_screen.dart';
import 'package:farmers_app/screens/machine_request_status.dart';
import 'package:farmers_app/screens/pesticides_and_fertilizers_list.dart';
import 'package:farmers_app/screens/profile_edit_screen.dart';
import 'package:farmers_app/screens/registration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmersDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/weather.png'),
                        fit: BoxFit.scaleDown)),
                height: 200,
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.thermostat),
                              label: Text(
                                  '${Provider.of<HttpProviders>(context).temp.toInt()}°C')),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.water_drop),
                              label: Text(
                                  '${Provider.of<HttpProviders>(context).humidity.toInt()}%')),
                        ],
                      ),
                      Expanded(child: Container()),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              Provider.of<HttpProviders>(context).weatherStatus,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(),
            // ListTile(
            //   title: const Text('Profile edit'), 
            //   trailing: const Icon(Icons.account_circle),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     Navigator.of(context).pushNamed(ProfileEditScreen.routeName);
            //   },
            // ),
            // const Divider(),
            ListTile(
              title: const Text('Machine requests'),
              trailing: const Icon(Icons.unarchive),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(MachineRequestStatus.routeName);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('View available machines'),
              trailing: const Icon(Icons.precision_manufacturing),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(MachinaryListScreen.routeName);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Admin notifications'),
              trailing: const Icon(Icons.notifications),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AdminNotifications.routeName);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('contact support team'),
              trailing: const Icon(Icons.support_agent),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(FAQList.routeName);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Pesticides & Fertilizers'),
              trailing: const Icon(Icons.sanitizer),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushNamed(PesticidesAndFertilizersList.routeName);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Feedback'),
              trailing: const Icon(Icons.feedback),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(FeedBackScreen.routeName);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                Navigator.of(context).pop();
                final pref = await SharedPreferences.getInstance();
                pref.setBool('isLogged', false);
                pref.remove('farmerId');
                Navigator.of(context)
                    .pushReplacementNamed(Registration.routeName);
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
