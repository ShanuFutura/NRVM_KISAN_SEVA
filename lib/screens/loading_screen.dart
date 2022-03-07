import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth=MediaQuery.of(context).size.width;
    return  Scaffold(
      body: Center(
          child: Icon(
        Icons.grass,
        color: Colors.green,
        size: deviceWidth *.3,
      )),
    );
  }
}
