import 'package:farmers_app/screens/crop_view.dart';
import 'package:farmers_app/screens/fertilizers_view.dart';
import 'package:flutter/material.dart';

class FertilizersListScreen extends StatelessWidget {
  const FertilizersListScreen({Key? key}) : super(key: key);

  static const String routeName = 'fertilizres';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fertilizers'),
      ),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(),
              title: Text('test'),
              subtitle: Text('test'),
              trailing: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(FertilizersView.routeName);
                },
                child: Text('test'),
              ),
            );
          }),
    );
  }
}
