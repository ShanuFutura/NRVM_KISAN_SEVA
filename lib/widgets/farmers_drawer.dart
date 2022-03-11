

import 'package:farmers_app/screens/admin_notifications.dart';
import 'package:farmers_app/screens/faq_list.dart';

import 'package:farmers_app/screens/machinary_list_screen.dart';
import 'package:farmers_app/screens/pesticides_and_fertilizers_list.dart';
import 'package:farmers_app/screens/profile_edit_screen.dart';
import 'package:farmers_app/screens/registration.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmersDrawer extends StatelessWidget {
  const FarmersDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Padding(
              padding: const  EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ProfileEditScreen.routeName);
                  },
                  child: CircleAvatar(
                    radius: 80,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Image.asset(
                          'assets/thermo_icon.webp',
                        ),
                       const   Positioned(
                          top: 100,
                          left: 90,
                          child: Text(
                            '30°C',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const  Divider(),
          ListTile(
            title: const  Text('View available machines'),
            trailing: const  Icon(Icons.precision_manufacturing),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(MachinaryListScreen.routeName);
            },
          ),
          const  Divider(),
          ListTile(
            title:  const Text('Admin notifications'),
            trailing:  const Icon(Icons.notifications),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(AdminNotifications.routeName);
            },
          ),
          const  Divider(),
          ListTile(
            title: const  Text('contact support team'),
            trailing: const  Icon(Icons.support_agent),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(FAQList.routeName);
            },
          ),
          const  Divider(),
          ListTile(
            title: const  Text('Pesticides & Fertilizers'),
            trailing:  const Icon(Icons.sanitizer),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushNamed(PesticidesAndFertilizersList.routeName);
            },
          ),
          const  Divider(),
          ListTile(
            title: const  Text('Logout'),
            trailing:  const Icon(Icons.logout),
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
    );
  }
}
