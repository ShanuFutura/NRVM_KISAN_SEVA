import 'package:farmers_app/models/dummies.dart';
import 'package:farmers_app/providers/http_providers.dart';
import 'package:farmers_app/widgets/apply_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MachinesView extends StatefulWidget {
  static const String routeName = 'machines';

  @override
  State<MachinesView> createState() => _MachinesViewState();
}

class _MachinesViewState extends State<MachinesView> {
  @override
  @override
  Widget build(BuildContext context) {
    // final deviceWidth = MediaQuery.of(context).size.width;
    final machineId = ModalRoute.of(context)!.settings.arguments;
    final machineData =
        (Provider.of<HttpProviders>(context).machinesList as List)
            .firstWhere((element) => element['equipment_id'] == machineId);
    print('machine Id' + machineId.toString());
    print('machineData' + machineData.toString());

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            title: const  Text(
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
                const  Padding(
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
                child: Text(
                  (machineData as Map)['equipment'],
                  style: const  TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                  shadowColor: Colors.black,
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      (machineData )['description'],
                      style:  const TextStyle(fontSize: 20),
                    ),
                  )),
            ],
          ),
        )),
      ]),
      floatingActionButton: ApplyButton(machineId: machineId),
    );
  }
}
