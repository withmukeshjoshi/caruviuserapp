import 'package:caruviuserapp/config/static.dart';
import 'package:http/http.dart' as http;

class BannerService {
  getAllBanners() async {
    var url = Uri.parse(serverADD + '/banner/');
    return http.get(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
  }
}
