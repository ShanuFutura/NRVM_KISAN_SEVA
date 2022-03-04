import 'package:farmers_app/providers/http_providers.dart';
import 'package:farmers_app/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registration extends StatefulWidget {
  Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
  static const String routeName = 'registration';
}

final fkey = GlobalKey<FormState>();

var username;
var name;
var email;
var phone;
var password;

class _RegistrationState extends State<Registration> {
  bool isLogin = true;
  bool isLoading = false;

  trySubmit() async {
    if (fkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      fkey.currentState!.save();
      var succeed;
      if (isLogin) {
        succeed = await Provider.of<HttpProviders>(context, listen: false)
            .farmerLogin(username, password);
        setState(() {
          isLoading = false;
        });
      }
      if (succeed) {
        final pref = await SharedPreferences.getInstance();
        pref.setBool('isLogged', true);
        Navigator.of(context).pushNamed(HomePage.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Form(
          key: fkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: isLogin ? deviceHeight * .3 : deviceHeight * .5,
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
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'usrename',
                          ),
                          validator: (v) {
                            if (v!.trim().isEmpty) {
                              return 'username cannot be empty';
                            }
                          },
                          onSaved: (v) {
                            username = v;
                          },
                        ),
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
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              hintText: 'name',
                            ),
                            validator: (v) {
                              if (v!.trim().isEmpty) {
                                return 'name cannot be empty';
                              }
                            },
                            onSaved: (v) {
                              name = v;
                            },
                          ),
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
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'email',
                            ),
                            validator: (v) {
                              if (v!.trim().isEmpty) {
                                return 'email is empty';
                              } else if (!v.contains('@') || !v.contains('.')) {
                                return 'email is badly formatted';
                              }
                            },
                            onSaved: (v) {
                              email = v;
                            },
                          ),
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
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'phone',
                            ),
                            validator: (v) {
                              if (v!.trim().isEmpty) {
                                return 'phone cannot be empty';
                              } else if (v.length != 10) {
                                return 'enter valid phone number';
                              }
                            },
                            onSaved: (v) {
                              phone = v;
                            },
                          ),
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
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'password',
                          ),
                          validator: (v) {
                            if (v!.trim().isEmpty) {
                              return 'enter password';
                            } else if (v.trim().length < 8) {
                              return 'password too short';
                            }
                          },
                          onSaved: (v) {
                            password = v;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        trySubmit();
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
      ),
    );
  }
}
