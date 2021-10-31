import 'dart:convert';

import 'package:caruviuserapp/config/static.dart';
import 'package:caruviuserapp/services/sharedPrefs.service.dart';
import 'package:http/http.dart' as http;

Future authenticateuser({String phoneNumber = "", String password = ""}) async {
  if (phoneNumber == '') print('Enter Valid Details');
  var url = Uri.parse(serverADD + '/login');
  var response = await http
      .post(url, body: {'phoneNumber': phoneNumber, 'password': password});
  if (response.statusCode == 201) saveDetailsLocally(response);
  if (response.statusCode == 201) return true;
  return false;
}

saveDetailsLocally(dynamic data) {
  var decodedResponse = jsonDecode(utf8.decode(data.bodyBytes)) as Map;
  if (decodedResponse['access_token'] != '' &&
      decodedResponse['access_token'] != null) {
    LocalStoredData().setStringKey('token', decodedResponse['access_token']);
    LocalStoredData().setIntKey('id', decodedResponse['id']);
    LocalStoredData().setStringKey('fullName', decodedResponse['fullName']);
    LocalStoredData()
        .setStringKey('emailAddress', decodedResponse['emailAddress']);
    LocalStoredData().setStringKey('address', decodedResponse['address']);
    LocalStoredData()
        .setStringKey('phoneNumber', decodedResponse['phoneNumber']);
    LocalStoredData()
        .setStringKey('businessName', decodedResponse['businessName']);
    LocalStoredData().setIntKey('cityId', decodedResponse['city']['id']);
    LocalStoredData().setStringKey('cityName', decodedResponse['city']['name']);
    LocalStoredData()
        .setStringKey('cityState', decodedResponse['city']['state']);
    LocalStoredData()
        .setStringKey('profilePicture', decodedResponse['profilePicture']);
    LocalStoredData().setStringKey('userType', decodedResponse['userType']);
    LocalStoredData().setBoolKey('isloggedin', true);
  }
}

logoutUser() {
  LocalStoredData().deleteKey('token');
  LocalStoredData().deleteKey('subscription');
  LocalStoredData().deleteKey('isloggedin');
  LocalStoredData().deleteKey('id');
  LocalStoredData().deleteKey('fullName');
  LocalStoredData().deleteKey('emailAddress');
  LocalStoredData().deleteKey('address');
  LocalStoredData().deleteKey('phoneNumber');
  LocalStoredData().deleteKey('businessName');
  LocalStoredData().deleteKey('cityId');
  LocalStoredData().deleteKey('cityName');
  LocalStoredData().deleteKey('cityState');
  LocalStoredData().deleteKey('profilePicture');
  LocalStoredData().deleteKey('userType');
}
