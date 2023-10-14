// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors

import 'dart:developer';

import 'package:comic_app/api/apiServices.dart';
import 'package:comic_app/common/colors.dart';
import 'package:comic_app/pages/comic/comic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:comic_app/pages/components/cache_image_with_cachemanager.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ChapterPage extends StatefulWidget {
  final id;
  final title;
  final image;
  const ChapterPage({
    super.key,
    required this.image,
    required this.title,
    required this.id,
  });

  @override
  State<ChapterPage> createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  late Future detail;

  @override
  void initState() {
    // TODO: implement initState
    detail = ApiServices().detail(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final scrollController = ScrollController();
    final autoScrollController = AutoScrollController();
    return Scaffold(
      body: NestedScrollView(
        controller: scrollController,
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(CupertinoIcons.back),
              color: Colors.white,
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(widget.title, textScaleFactor: 1),
            expandedHeight: size.height * 0.3,
            floating: true,
            pinned: false,
            snap: false,
            iconTheme: IconThemeData(color: Colors.black),
            flexibleSpace: Stack(
              alignment: Alignment.center,
              children: [
                FlexibleSpaceBar(
                  background: NetworkImageWithCacheManager(
                    imageUrl: widget.image,
                  ),
                ),
                Container(
                  color:
                      Colors.black.withOpacity(0.5), // Adjust opacity as needed
                ),
              ],
            ),
            backgroundColor: TextPrimary,
          )
        ],
        body: FutureBuilder(
          future: detail,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done)
              return Text("Loading");
            if (snapshot.hasError) return Text("Loading");
            if (snapshot.hasData)
              return listBuilder(snapshot.data.data, size, scrollController,
                  autoScrollController);
            return Text("Kosong");
          },
        ),
      ),
    );
  }

  Widget listBuilder(data, size, scrollController, autoScrollController) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: ListView.builder(
        // controller: scrollController,
        itemBuilder: (context, index) {
          return AutoScrollTag(
            controller: autoScrollController,
            index: index,
            key: ValueKey(data.chapter[index].title),
            child: Card(
              data: data.chapter[index],
            ),
          );
        },
        physics: BouncingScrollPhysics(),
        itemCount: data.chapter.length,
      ),
    );
  }
}

class Card extends StatelessWidget {
  final data;
  const Card({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(data.href);
        if (data.href != null) {
          Get.to(() => ComicPage(href: data.href, title: data.title,));
        } else {
          Get.snackbar(data.title, 'tidak tersedia',
              colorText: Colors.white,
              backgroundColor: Colors.black38,
              duration: const Duration(milliseconds: 1300),
              snackPosition: SnackPosition.BOTTOM);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: TextPrimary,
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.title,
                  style: kSubtitleTextStyle.copyWith(color: Colors.white),
                ),
                Text(
                  data.date,
                  style: kSubtitleTextStyle.copyWith(color: Colors.white24),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
