// To parse this JSON data, do
//
//     final recent = recentFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Recent recentFromJson(String str) => Recent.fromJson(json.decode(str));

String recentToJson(Recent data) => json.encode(data.toJson());

class Recent {
    String status;
    int currentPage;
    int lengthPage;
    List<Datum> data;

    Recent({
        required this.status,
        required this.currentPage,
        required this.lengthPage,
        required this.data,
    });

    factory Recent.fromJson(Map<String, dynamic> json) => Recent(
        status: json["status"],
        currentPage: json["current_page"],
        lengthPage: json["length_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "current_page": currentPage,
        "length_page": lengthPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String title;
    String href;
    String thumbnail;
    Type type;
    String chapter;
    String rating;

    Datum({
        required this.title,
        required this.href,
        required this.thumbnail,
        required this.type,
        required this.chapter,
        required this.rating,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        href: json["href"],
        thumbnail: json["thumbnail"],
        type: typeValues.map[json["type"]]!,
        chapter: json["chapter"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "href": href,
        "thumbnail": thumbnail,
        "type": typeValues.reverse[type],
        "chapter": chapter,
        "rating": rating,
    };
}

enum Type {
    MANGA,
    MANHUA,
    MANHWA
}

final typeValues = EnumValues({
    "Manga": Type.MANGA,
    "Manhua": Type.MANHUA,
    "Manhwa": Type.MANHWA
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
