// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'dart:async';
import 'dart:developer';
import 'package:comic_app/common/colors.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_app/api/apiServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/animation.dart';

class ComicPage extends StatefulWidget {
  final href;
  final title;
  const ComicPage({super.key, required this.href, required this.title});

  @override
  State<ComicPage> createState() => _ComicPageState();
}

class _ComicPageState extends State<ComicPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late Animation<Offset> _offsetAnimation;
  late Future read;
  bool isAppBarVisible = true;
  ScrollController _scrollController = ScrollController();
  final double appBarHeight = kToolbarHeight;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    read = ApiServices().read(widget.href);
    // TODO: implement initState

    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: Offset(0.0, 1.0),
    ).animate(_controller);
  }

  void toggleAppBarVisibility() {
    setState(() {
      isAppBarVisible = !isAppBarVisible;
      if (isAppBarVisible) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.top]);
        _controller.reverse();
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
        _controller.forward();
      }
    });

    // animation
  }

  void _handleScroll() {
    if (_scrollController.hasClients) {
      if (_scrollController.position.pixels == 0) {
        if (!isAppBarVisible) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
              overlays: []);
          isAppBarVisible = true;
        }
      } else {
        if (isAppBarVisible) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
              overlays: SystemUiOverlay.values);
          isAppBarVisible = false;
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: TextPrimary,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        key: _scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FixedBottomButton(size, isAppBarVisible),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Stack(
            children: [
              GestureDetector(
                onTap: toggleAppBarVisibility,
                child: FutureBuilder(
                    future: read,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState != ConnectionState.done)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      if (snapshot.hasError) return Text("Error");
                      if (snapshot.hasData)
                        return listBuilder(snapshot.data.data[0],
                            toggleAppBarVisibility, _scrollController);
                      return Text("Kosong");
                    }),
              ),
              isAppBarVisible
                  ? SafeArea(
                      child: PreferredSize(
                        preferredSize: Size.fromHeight(appBarHeight),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          height: isAppBarVisible ? appBarHeight : 0,
                          child: AppBar(
                            title: Text(widget.title),
                            backgroundColor: TextPrimary,
                            elevation: 0,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget listBuilder(
    data,
    toggleAppBarVisibility,
    _scrollController,
  ) {
    // log("${data.panel}");
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        if (isAppBarVisible) {
          setState(() {
            isAppBarVisible = false;
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                overlays: []);
            _controller.forward();
          });
        }
        return false;
      },
      child: ListView.builder(
        controller: _scrollController,
        itemCount: data.panel.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              CachedNetworkImage(
                imageUrl: data.panel[index],
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget FixedBottomButton(size, isAppBarVisible) {
    return SlideTransition(
      // height: isAppBarVisible ? size.height * 0.09 : 0,
      position: _offsetAnimation,
      child: Container(
        width: double.infinity, // Make the button take up the full width
        decoration: BoxDecoration(color: Colors.white),
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
                  backgroundColor: MaterialStatePropertyAll<Color>(TextPrimary),
                ),
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
                  backgroundColor: MaterialStatePropertyAll<Color>(TextPrimary),
                ),
                onPressed: () {
                  // Add your button's functionality here

                  print('Button3 Pressed');
                },
                child: Text("Read Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
