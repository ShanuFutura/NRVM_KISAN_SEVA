import 'package:farmers_app/screens/crop_view.dart';
import 'package:farmers_app/screens/machines_view.dart';
import 'package:flutter/material.dart';

class MachinaryListScreen extends StatelessWidget {
  const MachinaryListScreen({Key? key}) : super(key: key);

  static const String routeName = 'machinary lst';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tools and machines'),
      ),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(),
              title: Text('test'),
              subtitle: Text('test'),
              trailing: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(MachinesView.routeName);
                },
                child: Text('test'),
              ),
            );
          }),
    );
  }
}
