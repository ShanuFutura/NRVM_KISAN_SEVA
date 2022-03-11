

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
        print('passing: ' + username + password);
        succeed = await Provider.of<HttpProviders>(context, listen: false)
            .farmerLogin(username, password);
        setState(() {
          isLoading = false;
        });
      } else {
        succeed = await Provider.of<HttpProviders>(context, listen: false)
            .farmersRegister(name, email, phone, username, password);
        setState(() {
          isLoading = false;
        });
      }
      if (succeed) {
        final pref = await SharedPreferences.getInstance();
        pref.setBool('isLogged', true);
        Navigator.of(context).pushNamed(HomePage.routeName);
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return const  AlertDialog(
                title: Text('Couldn\'t login'),
                content: Text('Something went wrong'),
              );
            });
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
                    if (!isLogin)
                      Container(
                        key: const  Key('name'),
                        width: deviceWidth * .8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const  Color.fromARGB(125, 0, 128, 32)),
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
                        key:  const Key('mail'),
                        width: deviceWidth * .8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:  const Color.fromARGB(125, 0, 128, 32)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 15),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: const  InputDecoration(
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
                        key: const  Key('phone'),
                        width: deviceWidth * .8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const  Color.fromARGB(125, 0, 128, 32)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 15),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration:  const InputDecoration(
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
                      width: deviceWidth * .8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:  const Color.fromARGB(125, 0, 128, 32)),
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
                    Container(
                      key: const  Key('pass'),
                      width: deviceWidth * .8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:  const Color.fromARGB(125, 0, 128, 32)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 15),
                        child: TextFormField(
                          obscureText: true,
                          decoration: const  InputDecoration(
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
                  ? const  Center(
                      child: CircularProgressIndicator(),
                    )
                  : TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        trySubmit();
                      },
                      child: Text(
                        isLogin ? 'Login' : 'Signup',
                        style:  const TextStyle(fontSize: 30, color: Colors.green),
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
                  style:  const TextStyle(color: Color.fromARGB(255, 0, 97, 3)),
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
