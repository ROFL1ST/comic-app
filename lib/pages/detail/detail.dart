// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_app/common/colors.dart';
import 'package:comic_app/helpers/cache_manager.dart';
import 'package:comic_app/pages/detail/components/title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailPage extends StatefulWidget {
  final images;
  const DetailPage({super.key, required this.images});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  List<bool> _isSelected = [true, false];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    TextPrimary.withOpacity(0.5),
                    BlendMode.srcOver,
                  ),
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    widget.images,
                    cacheManager: CustomCacheManager.instance,
                  ),
                ),
              ),
              height: size.height * 0.4,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "Detail",
                          style: kListTitleStyle.copyWith(color: Colors.white),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            width: size.width / 3,
                            height: size.height / 4.5,
                            key: UniqueKey(),
                            imageUrl: widget.images.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: CupertinoButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        CupertinoIcons.back,
                        color: Colors.white,
                        size: size.width * 0.04,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.45,
                left: 25,
                right: 25,
                bottom: 20,
              ),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      // color: Colors.red, // hapus nanti
                      ),
                  width: size.width,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: cardBgPrimary,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            child: ToggleButtons(
                              children: <Widget>[
                                SizedBox(
                                  width: size.width / 2.46,
                                  child: Center(
                                    child: Text(
                                      'Information',
                                      style: kSubtitleTextStyle.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width / 2.46,
                                  child: Center(
                                      child: Text(
                                    'Chapter',
                                    style: kSubtitleTextStyle.copyWith(
                                      color: Colors.white,
                                    ),
                                  )),
                                ),
                              ],
                              onPressed: (int newIndex) {
                                setState(() {
                                  // Update the selected state
                                  for (int index = 0;
                                      index < _isSelected.length;
                                      index++) {
                                    if (index == newIndex) {
                                      _isSelected[index] = true;
                                    } else {
                                      _isSelected[index] = false;
                                    }
                                  }

                                  // Scroll to the selected page
                                  _pageController.animateToPage(
                                    newIndex,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                });
                              },
                              isSelected: _isSelected,
                              selectedBorderColor: TextPrimary,
                              borderRadius: BorderRadius.circular(8),
                              selectedColor: Colors.white,
                              color: Colors.white,
                              fillColor: TextPrimary,
                              highlightColor: TextPrimary,
                              borderColor: Colors.transparent,
                              hoverColor: TextPrimary,
                              focusColor: TextPrimary,
                              // disabledBorderColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width,
                        height: size.height / 2,
                        child: PageView(
                          controller: _pageController,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            // page information
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                // top
                                TitleDetail(),
                                // top
                                SizedBox(
                                  height: size.height * 0.04,
                                ),
                                
                              ],
                            ),
                            // page information
                            // page chapter
                            Center(
                              child: Text("DATA2"),
                            ),
                            // page chapter
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
