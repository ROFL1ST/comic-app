// To parse this JSON data, do
//
//     final read = readFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Read readFromJson(String str) => Read.fromJson(json.decode(str));

String readToJson(Read data) => json.encode(data.toJson());

class Read {
    String status;
    List<Datum> data;

    Read({
        required this.status,
        required this.data,
    });

    factory Read.fromJson(Map<String, dynamic> json) => Read(
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
    List<String> panel;

    Datum({
        required this.title,
        required this.panel,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        panel: List<String>.from(json["panel"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "panel": List<dynamic>.from(panel.map((x) => x)),
    };
}
