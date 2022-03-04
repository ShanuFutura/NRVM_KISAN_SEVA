import 'package:farmers_app/models/dummies.dart';
import 'package:farmers_app/providers/http_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CropView extends StatelessWidget {
  static const String routeName = 'cropview';

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final cropId = ModalRoute.of(context)!.settings.arguments;
    final cropData = (Provider.of<HttpProviders>(context).cropsList as List)
        .firstWhere((element) => element['crop_id'] == cropId);

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              (cropData as Map)['crop'],
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            background: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  height: 301,
                  child: Image.network(Dummies.rootUrlforImages +
                      'Images/' +
                      (cropData)['image']),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                )
              ],
            ),
          ),
        ),
        SliverFillRemaining(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Details',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: deviceWidth * .2),
                      child: Text(
                        'Season: ' + (cropData as Map)['season'],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Text((cropData as Map)['description'])
            ],
          ),
        )),
      ]),
    );
  }
}
