import 'package:farmers_app/models/dummies.dart';
import 'package:farmers_app/providers/http_providers.dart';
import 'package:farmers_app/widgets/apply_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MachinesView extends StatelessWidget {
  static const String routeName = 'pestview';

  @override
  Widget build(BuildContext context) {
    // final deviceWidth = MediaQuery.of(context).size.width;
    final machineId = ModalRoute.of(context)!.settings.arguments;
    final machineData =
        (Provider.of<HttpProviders>(context).machinesList as List)
            .firstWhere((element) => element['equipment_id'] == machineId);
    // print('machine Id' + machineId.toString());
    // print('machineData' + machineData.toString());

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text(
              '',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            background: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  width: double.infinity,
                  child: Image.network(
                    Dummies.rootUrlforImages +
                        'Images/' +
                        (machineData)['image'],
                    fit: BoxFit.fill,
                  ),
                ),
                
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
                child: Text(
                  (machineData as Map)['equipment'],
                  style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Text(machineData ['description']),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ApplyButton(machineId: machineId),
                ],
              ),
            ],
          ),
        )),
      ]),
    );
  }
}
