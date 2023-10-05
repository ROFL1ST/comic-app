// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:comic_app/common/colors.dart';
import 'package:comic_app/pages/detail/components/title.dart';
import 'package:flutter/material.dart';

class desc extends StatefulWidget {
  const desc({
    super.key,
    required this.size,
    required this.data,
  });

  final Size size;
  final data;

  @override
  State<desc> createState() => _descState();
}

class _descState extends State<desc> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: widget.size.height * 0.02,
        ),
        // top
        TitleDetail(data: widget.data),
        // top
        SizedBox(
          height: widget.size.height * 0.03,
        ),
        // description
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Description",
              style: kTitleTextStyle.copyWith(
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: widget.size.height * 0.01,
            ),
            SizedBox(
              width: widget.size.width / 1.3,
              child: AutoSizeText(
                widget.data.description,
                style: kSubtitleDetailStyle,
              ),
            )
          ],
        )
        // description
      ],
    );
  }
}
