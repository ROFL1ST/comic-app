import 'dart:convert';
import 'dart:developer';
import 'package:comic_app/api/model/recommend.dart';
import 'package:comic_app/api/model/update.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  // ignore: non_constant_identifier_names
  String base_url = "https://komikcast-api.cyclic.app/";
  String terbaru = "terbaru";
  String recommend = "recommended";

  Future recent(page) async {
    Uri urlApi = Uri.parse(base_url + terbaru + "?page=$page");
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final res = await http.get(urlApi);
    // print(res.body);
    if (res.statusCode == 200) {
      return recentFromJson(res.body.toString());
    } else {
      return false;
    }
  }

  Future recommendation() async {
    Uri urlApi = Uri.parse(base_url + recommend);
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final res = await http.get(urlApi);
    print(res.body);
    if (res.statusCode == 200) {
      return recommendFromJson(res.body.toString());
    } else {
      return false;
    }
  }
}
