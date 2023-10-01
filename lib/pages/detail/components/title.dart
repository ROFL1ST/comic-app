// ignore_for_file: prefer_const_constructors

import 'package:comic_app/common/colors.dart';
import 'package:flutter/material.dart';

class TitleDetail extends StatefulWidget {
  const TitleDetail({super.key});

  @override
  State<TitleDetail> createState() => _TitleDetailState();
}

class _TitleDetailState extends State<TitleDetail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width / 1.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "SAO : ALICIZATION",
            style: kTitleTextStyle.copyWith(
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Reki Kawahara",
                style: kSubtitleTextStyle,
              ),
              VerticalDivider(
                width: 10,
                color: Colors.black,
                thickness: 1,
                indent: 1,
                endIndent: 1,
              ),
              Row(
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
              VerticalDivider(
                width: 10,
                color: Colors.black,
                thickness: 1,
                indent: 1,
                endIndent: 1,
              ),
              Text(
                "Last Chapter : 10",
                style: kSubtitleTextStyle,
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: TextPrimary, borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                  child: Text(
                    "Adventure",
                    style: kListSubtitle.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
