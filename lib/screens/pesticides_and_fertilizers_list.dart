import 'package:farmers_app/providers/http_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PesticidesAndFertilizersList extends StatelessWidget {
  const PesticidesAndFertilizersList({Key? key}) : super(key: key);

  static const String routeName = 'pesticides';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesticides & Fertilizers'),
      ),
      body: FutureBuilder(
        future: Provider.of<HttpProviders>(context).getPesticides(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snap.hasData) {
            return ListView.builder(
                itemCount: (snap.data as List).length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    onTap: () {},
                    title: Text((snap.data as dynamic)[index]['name']),
                    // subtitle: Text((snap.data as dynamic)[index]['']),
                    trailing: TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Details'),
                                  content: Text((snap.data as dynamic)[index]
                                      ['description']),
                                );
                              });
                        },
                        child: Text('View')),
                  );
                }));
          } else {
            return Center(
              child: Text('Couldn\' fetch data'),
            );
          }
        },
      ),
    );
  }
}
