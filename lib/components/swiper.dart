import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:caruviuserapp/model/bannerModel.dart';
import 'package:flutter/material.dart';

class SwiperComponent extends StatefulWidget {
  final List<BannerModel> banners;
  SwiperComponent({
    required this.banners,
  });
  @override
  State<SwiperComponent> createState() => _SwiperComponentState();
}

class _SwiperComponentState extends State<SwiperComponent> {
  late PageController _pageController;
  int activePage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => slider());
  }

  void slider() {
    if (widget.banners.length != (activePage + 1)) {
      _pageController.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeIn);
      activePage++;
    } else {
      activePage = 1;
      _pageController.animateToPage(0,
          duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    }
  }

  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(1.0, 1.0),
                end: Alignment(1.0, 0.0),
                colors: [Colors.teal[500]!, Colors.teal[600]!])),
        height: 130.0,
      )),
      Container(
        height: 180.0,
        child: PageView.builder(
            itemCount: widget.banners.length,
            pageSnapping: true,
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                activePage = page;
              });
            },
            itemBuilder: (context, pagePosition) {
              return Container(
                margin: EdgeInsets.only(right: 5.0),
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: widget.banners[pagePosition].imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 110.0,
                    placeholder: (context, url) => Image.asset(
                      'assets/placeholder.jpg',
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/placeholder.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              );
            }),
      )
    ]);
  }
}
