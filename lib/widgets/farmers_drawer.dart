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
              //  Navigator.of(context).pushNamed(EmployeesListScreen.routeName);
              Navigator.of(context).pop();
            },
          ),
          Divider(),
          ListTile(
            title: Text('view fertilizers'),
            trailing: Icon(Icons.grass),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Divider(),
          ListTile(
            title: Text('Admin notificatio'),
            trailing: Icon(Icons.notifications),
            onTap: () {
              // Navigator.of(context).pushNamed(ParolList.routeName);
              Navigator.of(context).pop();
            },
          ),
          Divider(),
          ListTile(
            title: Text('contact support team'),
            trailing: Icon(Icons.support_agent),
            onTap: () {
              // Navigator.of(context).pushNamed(FeedBackScreen.routeName);
              Navigator.of(context).pop();
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
