import 'package:farmers_app/models/dummies.dart';
import 'package:flutter/material.dart';

class AdminNotifications extends StatelessWidget {
  const AdminNotifications({Key? key}) : super(key: key);
  static const String routeName = 'admin noti';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: ListView.builder(
        itemCount: Dummies.faqList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(Dummies.faqList[index]),
            ),
          );
        },
      ),
    );
  }
}
