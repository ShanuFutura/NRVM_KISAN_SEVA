import 'package:farmers_app/screens/home_page.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
  static const String routeName = 'registration';
}

class _RegistrationState extends State<Registration> {
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: deviceHeight * .3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 40,
                    width: deviceWidth * .8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(125, 0, 128, 32)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 15),
                      child: TextFormField(),
                    ),
                  ),
                  if (!isLogin)
                    Container(
                      height: 40,
                      width: deviceWidth * .8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(51, 0, 87, 29)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 15),
                        child: TextFormField(),
                      ),
                    ),
                  Container(
                    height: 40,
                    width: deviceWidth * .8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(51, 0, 31, 8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 15),
                      child: TextFormField(),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(HomePage.routeName);
              },
              child: Text(
                isLogin ? 'Login' : 'Sign Up',
                style: TextStyle(fontSize: 30, color: Colors.green),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(
                isLogin ? 'signup instead' : 'login instead',
                style: TextStyle(color: Color.fromARGB(255, 0, 97, 3)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
