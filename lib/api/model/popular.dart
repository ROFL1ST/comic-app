// To parse this JSON data, do
//
//     final popular = popularFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Popular popularFromJson(String str) => Popular.fromJson(json.decode(str));

String popularToJson(Popular data) => json.encode(data.toJson());

class Popular {
    String status;
    List<Datum> data;

    Popular({
        required this.status,
        required this.data,
    });

    factory Popular.fromJson(Map<String, dynamic> json) => Popular(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String title;
    String href;
    String genre;
    String year;
    String thumbnail;

    Datum({
        required this.title,
        required this.href,
        required this.genre,
        required this.year,
        required this.thumbnail,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        href: json["href"],
        genre: json["genre"],
        year: json["year"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "href": href,
        "genre": genre,
        "year": year,
        "thumbnail": thumbnail,
    };
}
