import 'package:farmers_app/screens/admin_notifications.dart';
import 'package:farmers_app/screens/faq_list.dart';
import 'package:farmers_app/screens/fertilizers_list_screen.dart';
import 'package:farmers_app/screens/machinary_list_screen.dart';
import 'package:farmers_app/screens/profile_edit_screen.dart';
import 'package:flutter/material.dart';

class FarmersDrawer extends StatelessWidget {
  const FarmersDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            // height: 300,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ProfileEditScreen.routeName);
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/avatar.png'),
                    radius: 80,
                    // backgroundImage: profileImage != null
                    //     ? FileImage(profileImage) as ImageProvider
                    //     : AssetImage(
                    //         'assets/avatar.png',
                    //       ),
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Text('View available machines'),
            trailing: Icon(Icons.precision_manufacturing),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(MachinaryListScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            title: Text('view fertilizers'),
            trailing: Icon(Icons.grass),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(FertilizersListScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Admin notifications'),
            trailing: Icon(Icons.notifications),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(AdminNotifications.routeName);
            },
          ),
          Divider(),
          ListTile(
            title: Text('contact support team'),
            trailing: Icon(Icons.support_agent),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(FAQList.routeName);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
