import 'dart:convert';

import 'package:farmers_app/models/dummies.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class HttpProviders extends ChangeNotifier {
  Future<bool> farmerLogin(String username, String password) async {
    final res = await post(Uri.parse(Dummies.rootUrl + 'login.php'),
        body: {'username': username, 'password': password});
    print(res.body);

    return jsonDecode(res.body)['message'] == 'User Successfully LoggedIn';
  }

  Future<dynamic> getCrops() async {
    final res = await get(Uri.parse(Dummies.rootUrl + 'login.php'));
    print('crops list' + res.body);
    return jsonDecode(res.body);
  }
}
