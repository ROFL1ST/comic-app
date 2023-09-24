import 'dart:convert';
import 'dart:developer';
import 'package:comic_app/api/model/popular.dart';
import 'package:comic_app/api/model/recommend.dart';
import 'package:comic_app/api/model/update.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  // ignore: non_constant_identifier_names
  String base_url = "https://komikcast-api.cyclic.app/";
  String terbaru_url = "terbaru";
  String recommend_url = "recommended";
  String popular_url = "popular";

  Future recent(page) async {
    Uri urlApi = Uri.parse(base_url + terbaru_url + "?page=$page");
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final res = await http.get(urlApi, headers: requestHeaders);
    // print(res.body);
    if (res.statusCode == 200) {
      return recentFromJson(res.body.toString());
    } else {
      return false;
    }
  }

  Future recommendation() async {
    Uri urlApi = Uri.parse(base_url + recommend_url);
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final res = await http.get(urlApi, headers: requestHeaders);
    // print(res.body);
    if (res.statusCode == 200) {
      return recommendFromJson(res.body.toString());
    } else {
      return false;
    }
  }

  Future popular() async {
    Uri urlApi = Uri.parse(base_url + popular_url);
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final res = await http.get(urlApi, headers: requestHeaders);
    print(res.body);
    if (res.statusCode == 200) {
      return popularFromJson(res.body.toString());
    } else {
      return false;
    }
  }
}
