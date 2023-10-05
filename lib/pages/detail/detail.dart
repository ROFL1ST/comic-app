// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_app/api/apiServices.dart';
import 'package:comic_app/common/colors.dart';
import 'package:comic_app/helpers/cache_manager.dart';
import 'package:comic_app/pages/detail/components/desc.dart';
import 'package:comic_app/pages/detail/components/title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailPage extends StatefulWidget {
  final id;
  final images;
  const DetailPage({
    super.key,
    required this.images,
    required this.id,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future detail;

  final PageController _pageController = PageController();

  List<bool> _isSelected = [true, false];
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    detail = ApiServices().detail(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    log("${detail} hai \n ${widget.id}");

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FixedBottomButton(size),
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
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
              height: size.height * 0.38,
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
                            height: size.height / 4.7,
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
                top: size.height * 0.38,
                left: 27,
                right: 27,
                bottom: 90,
              ),
              child: Container(
                decoration: BoxDecoration(
                    // color: Colors.red, // hapus nanti
                    ),
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: cardBgPrimary,
                    //     borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: AnimatedContainer(
                    //       duration: Duration(milliseconds: 300),
                    //       child: ToggleButtons(
                    //         children: <Widget>[
                    //           SizedBox(
                    //             width: size.width / 2.46,
                    //             child: Center(
                    //               child: Text(
                    //                 'Information',
                    //                 style: kSubtitleTextStyle.copyWith(
                    //                   color: Colors.white,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             width: size.width / 2.46,
                    //             child: Center(
                    //                 child: Text(
                    //               'Chapter',
                    //               style: kSubtitleTextStyle.copyWith(
                    //                 color: Colors.white,
                    //               ),
                    //             )),
                    //           ),
                    //         ],
                    //         onPressed: (int newIndex) {
                    //           setState(() {
                    //             // Update the selected state
                    //             for (int index = 0;
                    //                 index < _isSelected.length;
                    //                 index++) {
                    //               if (index == newIndex) {
                    //                 _isSelected[index] = true;
                    //               } else {
                    //                 _isSelected[index] = false;
                    //               }
                    //             }

                    //             // Scroll to the selected page
                    //             _pageController.animateToPage(
                    //               newIndex,
                    //               duration: Duration(milliseconds: 300),
                    //               curve: Curves.easeInOut,
                    //             );
                    //           });
                    //         },
                    //         isSelected: _isSelected,
                    //         selectedBorderColor: TextPrimary,
                    //         borderRadius: BorderRadius.circular(8),
                    //         selectedColor: Colors.white,
                    //         color: Colors.white,
                    //         fillColor: TextPrimary,
                    //         highlightColor: TextPrimary,
                    //         borderColor: Colors.transparent,
                    //         hoverColor: TextPrimary,
                    //         focusColor: TextPrimary,
                    //         // disabledBorderColor: Colors.transparent,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SingleChildScrollView(
                    //   child: SizedBox(
                    //     width: size.width,
                    //     height: size.height / 1.2,
                    //     child: FutureBuilder(
                    //       future: detail,
                    //       builder: (context, AsyncSnapshot snapshot) {
                    //         if (snapshot.connectionState !=
                    //             ConnectionState.done) return Text("Loading");
                    //         if (snapshot.hasError) return Text("Error");
                    //         if (snapshot.hasData)
                    //           return PageView(
                    //             controller: _pageController,
                    //             physics: NeverScrollableScrollPhysics(),
                    //             children: [
                    //               // page information
                    //               PageOne(size: size, data: snapshot.data.data),
                    //               // page information
                    //               // page chapter
                    //               PageSecond(size: size, data: snapshot.data.data)
                    //               // page chapter
                    //             ],
                    //           );
                    //         return Text("Kosong");
                    //       },
                    //     ),
                    //   ),
                    // ),

                    FutureBuilder(
                      future: detail,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text("Loading");
                        if (snapshot.hasError) return Text("Error");
                        if (snapshot.hasData)
                          return desc(size: size, data: snapshot.data.data);
                        return Text("Kosong");
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget FixedBottomButton(size) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 10  ,
            blurRadius: 7,
            offset: Offset(0, 10),
          ),
        ],
      ),

      width: double.infinity, // Make the button take up the full width

      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: size.height * 0.06,
            width: size.width * 0.13,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(TextPrimary)),
              onPressed: () {
                // Add your button's functionality here
                print('Button Pressed');
              },
              child: Center(child: Icon(Iconsax.save_2)),
            ),
          ),
          SizedBox(
            height: size.height * 0.06,
            width: size.width * 0.76,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(TextPrimary)),
              onPressed: () {
                // Add your button's functionality here

                print('Button3 Pressed');
              },
              child: Text("Read Now"),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomScrollbar extends StatefulWidget {
  final Widget child;

  CustomScrollbar({required this.child});

  @override
  _CustomScrollbarState createState() => _CustomScrollbarState();
}

class _CustomScrollbarState extends State<CustomScrollbar> {
  double scrollPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: 8.0,
            color: Colors.grey,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {
                  scrollPosition += details.delta.dy;
                  if (scrollPosition < 0) {
                    scrollPosition = 0;
                  } else if (scrollPosition > 1) {
                    scrollPosition = 1;
                  }
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: scrollPosition * 200.0),
                width: 8.0,
                height: 50.0,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
