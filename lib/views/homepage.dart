import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:caruviuserapp/components/swiper.dart';
import 'package:caruviuserapp/model/CityCategoryModel.dart';
import 'package:caruviuserapp/model/CityWc.dart';
import 'package:caruviuserapp/model/bannerModel.dart';
import 'package:caruviuserapp/services/banner.service.dart';
import 'package:caruviuserapp/services/city.service.dart';
import 'package:caruviuserapp/services/quote.service.dart';
import 'package:caruviuserapp/services/sharedPrefs.service.dart';
import 'package:caruviuserapp/services/user.service.dart';
import 'package:caruviuserapp/views/category_page.dart';
import 'package:caruviuserapp/views/category_page_transport.dart';
import 'package:caruviuserapp/views/profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late FirebaseMessaging messaging;
  PageController _pageController = new PageController(
    initialPage: 0,
  );
  int currentPage = 0;
  String location = "Loading";
  String searchTerm = "";
  List<BannerModel> banners = [];
  bool loadingCategories = true;
  Map<String, List<CategoryModel>> categories = new Map();
  @override
  void initState() {
    loadDetails();
    getBanners();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print(value);
      if (value != null) {
        updateMyToken(value);
      }
    });

    messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print(message);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
    super.initState();
  }

  loadDetails() async {
    String getCity = await LocalStoredData().getStringKey('cityName');
    int getCityId = await LocalStoredData().getIntKey('cityId');
    print(getCityId);
    var response = await CityService().getCategories(getCityId);
    if (response.statusCode == 200) {
      var parsedData = jsonDecode(response.body).cast<String, dynamic>();
      CityWithCategoryModel currentCity =
          CityWithCategoryModel.fromJson(parsedData);
      currentCity.categories.forEach((element) {
        if (!categories.containsKey(element['type'])) {
          categories[element['type']] = [];
        }
        categories[element['type']]!.add(CategoryModel.fromJson(element));
      });
    }
    setState(() {
      location = getCity;
      loadingCategories = false;
    });
  }

  getBanners() async {
    var response = await BannerService().getAllBanners();
    if (response.statusCode == 200) {
      var parsedData = jsonDecode(response.body).cast();
      parsedData.forEach((item) => banners.add(BannerModel.fromJson(item)));

      setState(() {});
    }
  }

  Widget getTextWidgets() {
    List<Widget> list = [];
    if (this.categories.length == 0) {
      return Center(
        child: Column(
          children: [
            SizedBox(
              height: 100.0,
            ),
            Image.asset(
              'assets/farming.png',
              width: 60.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text("Nothing to show"),
            SizedBox(
              height: 100.0,
            ),
          ],
        ),
      );
    }
    this.categories.forEach((key, value) {
      list.add(Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          value.length == 1
              ? SizedBox()
              : Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Text(
                    key,
                    style: GoogleFonts.lato(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  )),
          Container(
            height: value.length == 1
                ? 260.0
                : (value.length < 4)
                    ? 150.0
                    : 130.0,
            margin: EdgeInsets.only(bottom: 5.0),
            child: ListView.builder(
                physics: value.length == 1
                    ? NeverScrollableScrollPhysics()
                    : ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection:
                    value.length == 1 ? Axis.vertical : Axis.horizontal,
                itemCount: value.length,
                itemBuilder: (BuildContext context, index) {
                  print(value.length);

                  if (value.length == 1) {
                    return GestureDetector(
                        child: Container(
                          width: 100.0,
                          height: 230.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl: value[index].photo,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 130.0,
                                  placeholder: (context, url) => Image.asset(
                                    'assets/placeholder.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/placeholder.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0)),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            value[index].name,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.lato(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            value[index].description,
                                            style: GoogleFonts.lato(
                                                height: 1.4,
                                                fontSize: 10.0,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                          color: Colors.teal[50],
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      padding: EdgeInsets.all(10.0),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.remove_red_eye_outlined,
                                          size: 16.0,
                                          color: Colors.teal[500],
                                        ),
                                        onPressed: () {
                                          if (value[index].type ==
                                              'Transport') {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TransportCategoryPage(
                                                          category:
                                                              value[index],
                                                        )));
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CategoryPage(
                                                          category:
                                                              value[index],
                                                        )));
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                margin: EdgeInsets.all(13.0),
                              )
                            ],
                          ),
                          margin: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 3,
                                blurRadius: 10,
                                offset:
                                    Offset(0, 5), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          if (value[index].type == 'Transport') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TransportCategoryPage(
                                          category: value[index],
                                        )));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoryPage(
                                          category: value[index],
                                        )));
                          }
                        });
                  }
                  if (value.length < 4) {
                    return GestureDetector(
                        child: Container(
                          width: 110.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl: value[index].photo,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 80.0,
                                  placeholder: (context, url) => Image.asset(
                                    'assets/placeholder.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/placeholder.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0)),
                              ),
                              Container(
                                color: Colors.white,
                                child: SizedBox(
                                  width: 90.0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        value[index].name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.lato(
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                margin: EdgeInsets.all(8.0),
                              )
                            ],
                          ),
                          margin: EdgeInsets.only(
                              left: 8.0, bottom: 20.0, right: 8.0, top: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 3,
                                blurRadius: 10,
                                offset:
                                    Offset(0, 5), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          if (value[index].type == 'Transport') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TransportCategoryPage(
                                          category: value[index],
                                        )));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoryPage(
                                          category: value[index],
                                        )));
                          }
                        });
                  }
                  return GestureDetector(
                    onTap: () {
                      if (value[index].type == 'Transport') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TransportCategoryPage(
                                      category: value[index],
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryPage(
                                      category: value[index],
                                    )));
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              width: 60.0,
                              child: CachedNetworkImage(
                                imageUrl: value[index].photo,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 130.0,
                                placeholder: (context, url) => Image.asset(
                                  'assets/placeholder.jpg',
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/placeholder.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              height: 60.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 60.0,
                          child: Text(
                            value[index].name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
        ],
      ));
    });

    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, children: list);
  }

  void _launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent, // Status bar
          ),
          actions: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                ))
          ],
          title: Row(
            children: [
              Icon(Icons.location_on_outlined, color: Colors.white),
              SizedBox(
                width: 5.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                        color: Colors.white),
                  ),
                  Text(
                    "Showing all services near you",
                    style: TextStyle(fontSize: 12.0, color: Colors.teal[900]),
                  ),
                ],
              )
            ],
          ),
          backgroundColor: Colors.teal[600],
          toolbarHeight: 60.0,
          elevation: 0.0,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (page) {
            if (page != 2) {
              _pageController.jumpToPage(page);
              setState(() {
                currentPage = page;
              });
            }
          },
          currentIndex: currentPage,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: "Requests"),
          ],
          enableFeedback: true,
          selectedItemColor: Colors.teal[800],
          elevation: 7.0,
        ),
        backgroundColor: Colors.white,
        body: PageView(
          controller: _pageController,
          children: [
            SingleChildScrollView(
                child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   alignment: Alignment.center,
                  //   width: double.infinity,
                  //   height: 200.0,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       SizedBox(
                  //         width: 250.0,
                  //         child: Column(
                  //           children: [
                  //             Text("Caruvi Services",
                  //                 textAlign: TextAlign.center,
                  //                 style: GoogleFonts.lato(
                  //                   fontSize: 20.0,
                  //                   height: 1.5,
                  //                   fontWeight: FontWeight.w600,
                  //                   color: Colors.white,
                  //                 )),
                  //             SizedBox(
                  //               height: 10.0,
                  //             ),
                  //             Text(
                  //                 "Get affordable price from verified Caruvi vendors",
                  //                 textAlign: TextAlign.center,
                  //                 style: GoogleFonts.lato(
                  //                   fontSize: 14.0,
                  //                   height: 1.2,
                  //                   color: Colors.white70,
                  //                 ))
                  //           ],
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 30.0,
                  //       ),
                  //       Container(
                  //         width: 300.0,
                  //         decoration: BoxDecoration(
                  //             border: Border.all(color: Colors.white)),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           mainAxisSize: MainAxisSize.max,
                  //           children: [
                  //             SizedBox(
                  //               width: 200.0,
                  //               child: TextField(
                  //                 cursorColor: Colors.white,
                  //                 style: TextStyle(color: Colors.white),
                  //                 onChanged: (value) {
                  //                   searchTerm = value;
                  //                 },
                  //                 decoration: InputDecoration(
                  //                     isDense: true,
                  //                     hintStyle: TextStyle(color: Colors.white),
                  //                     errorStyle:
                  //                         TextStyle(color: Colors.white),
                  //                     labelStyle:
                  //                         TextStyle(color: Colors.white),
                  //                     helperStyle:
                  //                         TextStyle(color: Colors.white),
                  //                     counterStyle:
                  //                         TextStyle(color: Colors.white),
                  //                     floatingLabelStyle:
                  //                         TextStyle(color: Colors.white),
                  //                     contentPadding: EdgeInsets.all(15.0),
                  //                     focusedBorder: OutlineInputBorder(
                  //                         borderSide: BorderSide.none,
                  //                         borderRadius:
                  //                             BorderRadius.circular(0.0)),
                  //                     enabledBorder: OutlineInputBorder(
                  //                         borderSide: BorderSide.none,
                  //                         borderRadius:
                  //                             BorderRadius.circular(0.0)),
                  //                     hintText: "Search Service"),
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               width: 50.0,
                  //               child: Container(
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     border: Border.all(
                  //                         color: Colors.white, width: 0.5)),
                  //                 child: IconButton(
                  //                   enableFeedback: true,
                  //                   splashColor: Colors.teal[100],
                  //                   icon: Icon(
                  //                     Icons.search,
                  //                     color: Colors.teal[500],
                  //                   ),
                  //                   onPressed: () {
                  //                     if (searchTerm != '') {
                  //                       Navigator.push(
                  //                           context,
                  //                           MaterialPageRoute(
                  //                               builder: (context) =>
                  //                                   SearchPage(
                  //                                     term: searchTerm,
                  //                                   )));
                  //                     } else {
                  //                       showSimpleNotification(
                  //                           Text(
                  //                             "Enter Search Term",
                  //                             style: TextStyle(
                  //                               color: Colors.black,
                  //                             ),
                  //                           ),
                  //                           elevation: 5.0,
                  //                           background: Colors.teal[200],
                  //                           leading: Icon(
                  //                             Icons.error,
                  //                             color: Colors.teal,
                  //                           ));
                  //                     }
                  //                   },
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  //   decoration: BoxDecoration(
                  //       gradient: LinearGradient(
                  //           begin: Alignment(1.0, 1.0),
                  //           end: Alignment(1.0, 0.0),
                  //           colors: [Colors.teal[500]!, Colors.teal[600]!])),
                  // ),
                  banners.length > 0
                      ? SwiperComponent(
                          banners: banners,
                        )
                      : Container(),
                  SizedBox(
                    height: 25.0,
                  ),
                  loadingCategories
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 25.0,
                              height: 25.0,
                              child: CircularProgressIndicator(
                                strokeWidth: 3.0,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text('Loading Categories')
                          ],
                        )
                      : getTextWidgets(),
                  // Container(
                  //     padding: EdgeInsets.all(10.0),
                  //     child: Text(
                  //       "Recently Viewed",
                  //       style: GoogleFonts.lato(
                  //           fontSize: 14.0,
                  //           fontWeight: FontWeight.w500,
                  //           color: Colors.black87),
                  //     )),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.stretch,
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: <Widget>[
                  //     SingleChildScrollView(
                  //       scrollDirection: Axis.horizontal,
                  //       child: Row(
                  //         children: <Widget>[
                  //           Container(
                  //             margin: EdgeInsets.symmetric(horizontal: 10.0),
                  //             decoration: BoxDecoration(
                  //                 color: Colors.white,
                  //                 border: Border.all(color: Colors.teal[100]!),
                  //                 borderRadius: BorderRadius.circular(4.0)),
                  //             padding: EdgeInsets.symmetric(
                  //                 vertical: 13.0, horizontal: 25.0),
                  //             child: Text("Car Service"),
                  //           ),
                  //           Container(
                  //             margin: EdgeInsets.symmetric(horizontal: 10.0),
                  //             decoration: BoxDecoration(
                  //                 color: Colors.white,
                  //                 border: Border.all(color: Colors.teal[100]!),
                  //                 borderRadius: BorderRadius.circular(4.0)),
                  //             padding: EdgeInsets.symmetric(
                  //                 vertical: 13.0, horizontal: 25.0),
                  //             child: Text("Mushroom"),
                  //           ),
                  //           Container(
                  //             margin: EdgeInsets.symmetric(horizontal: 10.0),
                  //             decoration: BoxDecoration(
                  //                 color: Colors.white,
                  //                 border: Border.all(color: Colors.teal[100]!),
                  //                 borderRadius: BorderRadius.circular(4.0)),
                  //             padding: EdgeInsets.symmetric(
                  //                 vertical: 13.0, horizontal: 25.0),
                  //             child: Text("Dhoopbatti"),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  SizedBox(
                    height: 50.0,
                  ),
                  Center(
                    child: Text(
                      'Made with ♡ by Caruvi Agro',
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.blueGrey[900],
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        'Caruvi continuously working for our member’s development by providing them skill trainings of various sectors based on agricultural and support them to start businesses on small scales initially.',
                        style: GoogleFonts.lato(
                            height: 1.4, fontSize: 12.0, color: Colors.black87),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            )),
            FutureBuilder(
                future: QuoteService().getLatestServices(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var parsedData = jsonDecode(snapshot.data);
                    if (parsedData.length > 0) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: parsedData.length,
                          itemBuilder: (context, i) {
                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl: parsedData[i]['category']
                                          ['photo'],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 100.0,
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        'assets/placeholder.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'assets/placeholder.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5.0),
                                        topRight: Radius.circular(5.0)),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                parsedData[i]['vendor']
                                                        ['businessName'] +
                                                    ' quoted ₹${parsedData[i]['amount']}',
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.lato(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                'Vendor Name: ${parsedData[i]['vendor']['fullName']}',
                                                maxLines: 3,
                                                style: GoogleFonts.lato(
                                                    height: 1.4,
                                                    fontSize: 12.0,
                                                    color: Colors.black54),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                "${parsedData[i]['category']['name']} - ${parsedData[i]['category']['type']}",
                                                style: GoogleFonts.lato(
                                                    fontSize: 12.0),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 50.0,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                              color: Colors.teal[50],
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
                                          padding: EdgeInsets.all(10.0),
                                          child: IconButton(
                                            tooltip: "Call Vendor",
                                            icon: Icon(
                                              Icons.phone,
                                              size: 16.0,
                                              color: Colors.teal[500],
                                            ),
                                            onPressed: () {
                                              var url = 'tel://' +
                                                  parsedData[i]['vendor']
                                                      ['phoneNumber'];
                                              _launchURL(url);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    margin: EdgeInsets.all(13.0),
                                  )
                                ],
                              ),
                              margin: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 3,
                                    blurRadius: 10,
                                    offset: Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                            );
                          });
                    } else {
                      return Column(
                        children: [
                          SizedBox(
                            height: 100.0,
                          ),
                          Image.asset(
                            'assets/farming.png',
                            width: 80.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text("Nothing to show")
                        ],
                      );
                    }
                  }

                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100.0,
                        ),
                        Image.asset(
                          'assets/loading.gif',
                          width: 140.0,
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ));
  }
}
