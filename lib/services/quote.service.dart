import 'package:caruviuserapp/config/static.dart';
import 'package:caruviuserapp/services/sharedPrefs.service.dart';
import 'package:http/http.dart' as http;

class QuoteService {
  Future getLatestServices() async {
    var token = await LocalStoredData().getStringKey('token');
    var userId = await LocalStoredData().getIntKey('id');
    var url = Uri.parse(serverADD + '/quote/request/${userId}');

    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return response.body;
  }
}
