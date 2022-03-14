import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:farmers_app/models/dummies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpProviders extends ChangeNotifier {
  var cropsList;
  var machinesList;
  var notifications;
  var temp = 0.0;
  var humidity = 0.0;

  Future<bool> farmerLogin(String username, String password) async {
    final pref = await SharedPreferences.getInstance();

    try {
      final res = await post(Uri.parse(Dummies.rootUrl + 'login.php'),
          body: {'username': username, 'password': password});
      print(res.body);
      if (jsonDecode(res.body)['message'] == 'User Successfully LoggedIn') {
        pref.setString('farmerId', jsonDecode(res.body)['farmer_id']);
        return true;
      } else
        return false;
    } on Exception catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> farmersRegister(
    String name,
    String email,
    String mobile,
    String username,
    String password,
  ) async {
    Response res;
    try {
      res = await post(Uri.parse(Dummies.rootUrl + 'register.php'), body: {
        'name': name,
        'email': email,
        'mobile': mobile,
        'username': username,
        'password': password,
      });
      print(res.body);

      final pref = await SharedPreferences.getInstance();
      pref.setString('farmerId', jsonDecode(res.body)['farmer_id']);
      return jsonDecode(res.body)['farmer_id'] != null;
    } on Exception catch (err) {
      print(err);
      return false;
    }
  }

  Future<dynamic> getCrops() async {
    final res = await get(Uri.parse(Dummies.rootUrl + 'crop_list.php'));
    print('crops list' + res.body);
    cropsList = jsonDecode(res.body);
    return jsonDecode(res.body);
  }

  Future<dynamic> getMachines() async {
    print('getting');
    final res = await get(Uri.parse(Dummies.rootUrl + 'machine_list.php'));
    print('machines' + res.body);
    machinesList = jsonDecode(res.body);
    return jsonDecode(res.body);
  }

  Future<bool> applyForMachine(String equipmentId) async {
    final pref = await SharedPreferences.getInstance();
    print(pref.getString('farmerId'));
    try {
      final res = await post(
          Uri.parse(Dummies.rootUrl + 'equipment_request.php'),
          body: {
            'farmer_id': pref.getString('farmerId'),
            'equipment_id': equipmentId
          });
      final resText = await json.decode(json.encode(res.body));
      print('application response' + resText.toString());
      return resText.toString().trim() == 'requested';
    } on Exception catch (err) {
      print(err);
      return false;
    }
  }

  Future<bool> sendFAQ(String doubt) async {
    final pref = await SharedPreferences.getInstance();

    final res = await post(Uri.parse(Dummies.rootUrl + 'doubt_send.php'),
        body: {'farmer_id': pref.getString('farmerId'), 'doubt': doubt});
    print('FAQ!!!!!!!!!!!!' + res.body);
    return jsonDecode(jsonEncode(res.body)).toString().trim() == 'successfull';
  }

  Future<dynamic> getNotifications() async {
    final res = await get(Uri.parse(Dummies.rootUrl + 'notification.php'));
    print('notifications : ' + res.body);
    notifications = jsonDecode(res.body);
    return jsonDecode(res.body);
  }

  Future<dynamic> getPesticides() async {
    final res = await get(Uri.parse(Dummies.rootUrl + 'pesticide_list.php'));
    print('pesticides : ' + res.body);
    notifications = jsonDecode(res.body);
    return jsonDecode(res.body);
  }

  Future<dynamic> getFAQList() async {
    final pref = await SharedPreferences.getInstance();
    final res = await post(Uri.parse(Dummies.rootUrl + 'doubt_list.php'),
        body: {'farmer_id': pref.getString('farmerId')});
    print('faqlist : ' + res.body);
    return jsonDecode(res.body);
  }

  // Future<dynamic> weather() async {
  //   final pref = await SharedPreferences.getInstance();
  //   final res = await post(Uri.parse(Dummies.rootUrl + 'iot.php'), body: {
  //     'farmer_id': pref.getString('farmerId'),
  //   });
  //   print('Temperature' + res.body);
  //   temp = jsonDecode(res.body)['temparature'];
  //   humidity = jsonDecode(res.body)['humidity'];
  // }

  String get weatherStatus {
    if (temp > 30 || humidity < 50) {
      return 'too hot consider irrigating';
    } else if (temp < 20 && humidity > 70) {
      return 'No need for further irrigation';
    } else {
      return 'Normal irrigation needed';
    }
  }

  Widget get WeatherIcon {
    if (temp > 35 || humidity < 30) {
      return Icon(Icons.wb_sunny);
    } else if (temp < 30 && humidity > 50) {
      return Icon(Icons.water_drop);
    } else {
      return Icon(Icons.thermostat);
      ;
    }
  }

  Future<dynamic> getSensorData() async {
    final url = Uri.parse(
        'https://api.thingspeak.com/channels/1672889/feeds.json?api_key=DAUOVF9HSVX6NS3A&results=2');
    final res = await get(url);
    print(res.body);
    temp =
        double.parse(((jsonDecode(res.body))['feeds'] as List).last['field1']);
    humidity =
        double.parse(((jsonDecode(res.body))['feeds'] as List).last['field2']);
    print(temp.toString() + humidity.toString());
  }

  Future<dynamic> getRequestStatus() async {
    final pref = await SharedPreferences.getInstance();
    final res = await post(Uri.parse(Dummies.rootUrl + 'request_status.php'),
        body: {'farmer_id': pref.getString('farmerId')});
    return jsonDecode(res.body);
  }

  Future<bool> getConnectivityStatus() async {
    print('called');
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    return (connectivityResult == ConnectivityResult.none);
  }
}
