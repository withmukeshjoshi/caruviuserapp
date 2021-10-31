import 'package:caruviuserapp/config/static.dart';
import 'package:caruviuserapp/services/sharedPrefs.service.dart';
import 'package:http/http.dart' as http;

class CityService {
  getCategories(int id) async {
    var token = await LocalStoredData().getStringKey('token');
    var url = Uri.parse(serverADD + '/city/wc/${id}');
    return http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
  }

  searchCategory(String id) async {
    var token = await LocalStoredData().getStringKey('token');
    var url = Uri.parse(serverADD + '/category/search?cat=${id}');
    return http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
  }
}
