import 'dart:convert';

import 'package:caruviuserapp/config/static.dart';
import 'package:caruviuserapp/model/Profile.dart';
import 'package:caruviuserapp/services/sharedPrefs.service.dart';
import 'package:caruviuserapp/services/user.service.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Subscription {
  Future getAllServices() async {
    var token = await LocalStoredData().getStringKey('token');
    var url = Uri.parse(serverADD + '/city/wc');
    return http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
  }

  getMySubscription() {
    print("Hello");
  }

  Future subscribeToService(int city, int category) async {
    Response response = await getMyProfile();
    print(response.statusCode);
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<String, dynamic>();
      final userProfile = Profile.fromJson(parsed);
      var token = await LocalStoredData().getStringKey('token');
      var url = Uri.parse(serverADD + '/subscription');
      return http.post(url,
          headers: {
            'Authorization': 'Bearer $token',
            "Content-Type": "application/json"
          },
          body: json.encode(
              {"user": userProfile.id, "city": city, "category": category}));
    }
  }

  cancelSubscription() {
    print("Hello");
  }
}
