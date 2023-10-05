// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_app/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PopularSec extends StatefulWidget {
  final popular;
  const PopularSec({super.key, required this.popular});

  @override
  State<PopularSec> createState() => _PopularSecState();
}

class _PopularSecState extends State<PopularSec> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Popular Series",
              style: kTitleTextStyle,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Iconsax.arrow_circle_right),
            )
          ],
        ),
        FutureBuilder(
            future: widget.popular,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return Text("Loading");
              if (snapshot.hasError) return Text("Error");
              if (snapshot.hasData)
                return listBuilder(size, snapshot.data.data);
              return Text("Kosong");
            })
      ],
    );
  }

  Widget listBuilder(size, data) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.01),
      width: size.width,
      child: data.length != 0
          ? Column(
              children: [
                ...List.generate(5, (i) {
                  return card(data[i], size, i);
                })
              ],
            )
          : SizedBox(),
    );
  }

  Widget card(data, size, index) {
    log("${data}");
    List<String> stringList = data.genre.split(',');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: size.width,
        height: size.height * 0.214,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    width: size.width / 3,
                    height: size.height,
                    key: UniqueKey(),
                    imageUrl: data.thumbnail.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.55,
                        child: AutoSizeText(
                          stringList[0],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          minFontSize: 15,
                          style: kListTitleStyle.copyWith(
                              color: stringList[0] == "Drama"
                                  ? drama
                                  : stringList[0] == "Action"
                                      ? action
                                      : stringList[0] == "Adventure"
                                          ? Adventure
                                          : stringList[0] == "Romance"
                                              ? romance
                                              : stringList[0] == "Fantasy"
                                                  ? fantasy
                                                  : null),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.55,
                        child: AutoSizeText(
                          data.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          minFontSize: 18,
                          style: kListTitleStyle,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: Color(0xFFFFD248),
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          // rating tidak ada
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
