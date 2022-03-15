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
        title:  const Text('Pesticides & Fertilizers'),
      ),
      body: FutureBuilder(
        future: Provider.of<HttpProviders>(context).getPesticides(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return  const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snap.hasData) {
            return ListView.builder(
                itemCount: (snap.data as List).length,
                itemBuilder: ((context, index) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {},
                        title: Text((snap.data as dynamic)[index]['name']),
                        trailing: TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title:  const Text('Details'),
                                      content: Text((snap.data as dynamic)[index]
                                          ['description']),
                                    );
                                  });
                            },
                            child:  const Text('View')),
                      ),
                      const Divider()
                    ],
                  );
                }));
          } else {
            return  const Center(
              child: Text('Couldn\' fetch data'),
            );
          }
        },
      ),
    );
  }
}
