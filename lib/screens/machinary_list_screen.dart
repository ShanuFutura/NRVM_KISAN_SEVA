import 'package:farmers_app/models/dummies.dart';
import 'package:farmers_app/providers/http_providers.dart';
import 'package:farmers_app/screens/machines_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MachinaryListScreen extends StatelessWidget {
  const MachinaryListScreen({Key? key}) : super(key: key);

  static const String routeName = 'machinary lst';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tools and machines'),
      ),
      body: FutureBuilder(
        future: Provider.of<HttpProviders>(context).getMachines(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snap.hasData) {
            return ListView.builder(
                itemCount: (snap.data as List).length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const Divider(),
                      ListTile(
                        contentPadding: const EdgeInsets.all(8),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              MachinesView.routeName,
                              arguments: (snap.data as dynamic)[index]
                                  ['equipment_id']);
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              Dummies.rootUrlforImages +
                                  'Images/' +
                                  (snap.data as dynamic)[index]['image']),
                        ),
                        title: Text((snap.data as dynamic)[index]['equipment']),
                        trailing: const TextButton(
                            onPressed: null, child: Icon(Icons.visibility)),
                      ),
                    ],
                  );
                });
          } else {
            return const Center(
              child: Text('couldn\'t fetch data'),
            );
          }
        },
      ),
    );
  }
}
