// To parse this JSON data, do
//
//     final recommend = recommendFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Recommend recommendFromJson(String str) => Recommend.fromJson(json.decode(str));

String recommendToJson(Recommend data) => json.encode(data.toJson());

class Recommend {
    String status;
    List<Datum> data;

    Recommend({
        required this.status,
        required this.data,
    });

    factory Recommend.fromJson(Map<String, dynamic> json) => Recommend(
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
    String rating;
    String chapter;
    String type;
    String thumbnail;

    Datum({
        required this.title,
        required this.href,
        required this.rating,
        required this.chapter,
        required this.type,
        required this.thumbnail,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        href: json["href"],
        rating: json["rating"],
        chapter: json["chapter"],
        type: json["type"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "href": href,
        "rating": rating,
        "chapter": chapter,
        "type": type,
        "thumbnail": thumbnail,
    };
}
