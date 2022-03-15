import 'package:farmers_app/providers/http_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MachineRequestStatus extends StatelessWidget {
  static const String routeName = 'machine req';
  MachineRequestStatus({Key? key}) : super(key: key);
  var stat = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Machine request status'),
      ),
      body: FutureBuilder(
          future: Provider.of<HttpProviders>(context).getRequestStatus(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              // List machines = Provider.of<HttpProviders>(context).machinesList;

              return ListView.builder(
                  itemCount: (snap.data as List).length,
                  itemBuilder: (context, index) {
                    if ((snap.data as dynamic)[index]['status'] == '0') {
                      stat = 'Pending';
                    } else if ((snap.data as dynamic)[index]['status'] == '1') {
                      stat = 'Accepted';
                    } else if ((snap.data as dynamic)[index]['status'] == '2') {
                      stat = 'Rejected';
                    } else {
                      stat = '';
                    }
                    return Column(
                      children: [
                        ListTile(
                          leading: Text(
                            (snap.data as dynamic)[index]['equipment'],
                            style: TextStyle(fontSize: 15),
                          ),
                          trailing: Text(
                            stat,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  });
            }
          }),
    );
  }
}
