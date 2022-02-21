import 'package:farmers_app/widgets/farmers_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = 'homepage';

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: FarmersDrawer(),
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: deviceHeight * .7,
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(),
                    title: Text('test'),
                    subtitle: Text('test'),
                    trailing: TextButton(
                      onPressed: () {},
                      child: Text('test'),
                    ),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: deviceHeight * .07,
                child: Icon(
                  Icons.quiz,
                  size: deviceHeight * .08,
                ),
              ),
              CircleAvatar(
                radius: deviceHeight * .07,
                child: Icon(
                  Icons.precision_manufacturing,
                  size: deviceHeight * .08,
                ),
              ),
              CircleAvatar(
                radius: deviceHeight * .07,
                child: Icon(
                  Icons.grass,
                  size: deviceHeight * .08,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
