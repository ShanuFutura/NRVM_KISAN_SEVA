

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
              style:  const TextStyle(color: Colors.white, fontSize: 20),
            ),
            background: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  height: double.infinity,
                  child: Image.network(
                    Dummies.rootUrlforImages + 'Images/' + (cropData)['image'],
                    fit: BoxFit.fill,
                  ),
                ),
                 const Padding(
                  padding:  EdgeInsets.all(10),
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
              const  SizedBox(
                height: 20,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: deviceWidth * .05),
                  child: Chip(
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Season: ' + (cropData )['season'],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ),
                  ),
                ),
              ),
              const  Padding(
                padding:
                     EdgeInsets.symmetric(vertical: 15, horizontal: 8.0),
                child: Text(
                  'Details',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                  shadowColor: Colors.black,
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      (cropData )['description'],
                      style:  const TextStyle(fontSize: 20),
                    ),
                  ))
            ],
          ),
        )),
      ]),
    );
  }
}
