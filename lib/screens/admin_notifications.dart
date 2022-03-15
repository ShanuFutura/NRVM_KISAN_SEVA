import 'package:farmers_app/providers/http_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminNotifications extends StatelessWidget {
  const AdminNotifications({Key? key}) : super(key: key);
  static const String routeName = 'admin noti';

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin notifications'),
      ),
      body: FutureBuilder(
        future: Provider.of<HttpProviders>(context).getNotifications(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snap.hasData) {
              return ListView.builder(
                itemCount: (snap.data as List).length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          (snap.data as dynamic)[index]['notification'],
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('Couldn\'t fetch data'),
              );
            }
          }
        },
      ),
    );
  }
}
