import 'dart:convert';

import 'package:caruviuserapp/config/static.dart';
import 'package:caruviuserapp/services/sharedPrefs.service.dart';
import 'package:http/http.dart' as http;

class RequestService {
  sendRequest(int catId, String description) async {
    var token = await LocalStoredData().getStringKey('token');
    var url = Uri.parse(serverADD + '/request');
    return http.post(url,
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        },
        body: json.encode({'category': catId, 'description': description}));
  }
}
