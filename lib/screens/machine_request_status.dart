import 'package:farmers_app/providers/http_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MachineRequestStatus extends StatelessWidget {
  const MachineRequestStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: Provider.of<HttpProviders>(context).getRequestStatus(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List machines = Provider.of<HttpProviders>(context).machinesList;
              return ListView.builder(
                  itemCount: (snap as List).length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text((machines as List)[index]['equipment_id']),
                    );
                  });
            }
          }),
    );
  }
}
