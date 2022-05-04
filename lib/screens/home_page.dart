import 'package:farmers_app/models/dummies.dart';
import 'package:farmers_app/providers/http_providers.dart';
import 'package:farmers_app/screens/crop_view.dart';
import 'package:farmers_app/screens/faq_list.dart';

import 'package:farmers_app/screens/machinary_list_screen.dart';
import 'package:farmers_app/screens/pesticides_and_fertilizers_list.dart';
import 'package:farmers_app/widgets/farmers_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = 'homepage';

  @override
  Widget build(BuildContext context) {
    Provider.of<HttpProviders>(context).getConnectivityStatus().then((value) {
      // print(value);
      if (value) {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text('Consider turning data on'),
              );
            });
      }
    });
    final deviceHeight = MediaQuery.of(context).size.height;
    // final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: FarmersDrawer(),
      appBar: AppBar(
        title: const Text('Farmers App'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: FutureBuilder(
                  future: Provider.of<HttpProviders>(context).getSensorData(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(
                                        Provider.of<HttpProviders>(context)
                                            .weatherStatus),
                                  );
                                });
                          },
                          child: StreamBuilder(
                              stream: Stream.periodic(Duration(seconds: 1)),
                              builder: (context, snap) {
                                Provider.of<HttpProviders>(context)
                                    .getSensorData();
                                return Provider.of<HttpProviders>(context)
                                    .weatherIcon;
                              }));
                    }
                  }),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<HttpProviders>(context).getCrops(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snap.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Crops',
                    style: TextStyle(
                        fontSize: 25, color: Theme.of(context).primaryColor),
                  ),
                ),
                Container(
                  height: deviceHeight * .65,
                  child: ListView.builder(
                      itemCount: (snap.data as List).length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Divider(),
                              ListTile(
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(Dummies
                                          .rootUrlforImages +
                                      'Images/' +
                                      (snap.data as dynamic)[index]['image']),
                                ),
                                title:
                                    Text((snap.data as dynamic)[index]['crop']),
                                trailing: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        CropView.routeName,
                                        arguments: (snap.data as dynamic)[index]
                                            ['crop_id']);
                                  },
                                  child: const Text('view'),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(MachinaryListScreen.routeName);
                        },
                        child: Container(
                            height: deviceHeight * .05,
                            child: Image.asset('assets/tools.png'))),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(FAQList.routeName);
                      },
                      child: Icon(
                        Icons.quiz,
                        size: deviceHeight * .05,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              PesticidesAndFertilizersList.routeName);
                        },
                        child: Container(
                            height: deviceHeight * .05,
                            child: Image.asset('assets/pesticide.png'))),
                  ],
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Couldnt fetch data'),
            );
          }
        },
      ),
    );
  }
}
