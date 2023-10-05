// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:comic_app/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TitleDetail extends StatefulWidget {
  const TitleDetail({super.key, required this.data});
  final data;
  @override
  State<TitleDetail> createState() => _TitleDetailState();
}

class _TitleDetailState extends State<TitleDetail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      // width: size.width / 1.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.data.title,
            style: kTitleTextStyle.copyWith(
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,

            spacing: 8.0, // Horizontal spacing between children
            runSpacing: 8.0, // Vertical spacing between lines
            children: [
              Text(
                widget.data.author,
                style: kSubtitleTextStyle,
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: Color(0xFFFFD248),
                  ),
                  SizedBox(
                    width: size.width * 0.008,
                  ),
                  Text(
                    "8.7",
                    style: TextStyle(
                        color: Color(0xFFFFD248), fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Wrap(
            spacing: 8.0, // Horizontal spacing between children
            runSpacing: 8.0, // Vertical spacing between lines
            children: [
              ...widget.data.genre.map((data) {
                log("$data");
                return Container(
                  // margin: EdgeInsets.only(right: 8, bottom: 8),
                  decoration: BoxDecoration(
                      color: TextPrimary,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                    child: Text(
                      data.title,
                      style: kListSubtitle.copyWith(color: Colors.white),
                    ),
                  ),
                );
              }).toList()
            ],
          )
        ],
      ),
    );
  }
}
