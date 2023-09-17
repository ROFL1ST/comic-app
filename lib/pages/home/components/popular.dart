// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:comic_app/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Popular extends StatefulWidget {
  const Popular({super.key});

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {
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
        listBuilder(size)
      ],
    );
  }

  Widget listBuilder(size) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.01),
      width: size.width,
      
    );
  }
}
