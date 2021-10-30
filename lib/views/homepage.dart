import 'dart:convert';
import 'dart:developer';

import 'package:caruviuserapp/model/CityCategoryModel.dart';
import 'package:caruviuserapp/model/CityWc.dart';
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
import 'package:http/http.dart';
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
  bool loadingCategories = true;
  Map<String, List<CategoryModel>> categories = new Map();
  @override
  void initState() {
    loadDetails();
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

  Widget getTextWidgets() {
    List<Widget> list = [];
    this.categories.forEach((key, value) {
      list.add(Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Text(
                key,
                style: GoogleFonts.lato(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              )),
          Container(
            height: 140.0,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categories[key]!.length,
                itemBuilder: (BuildContext context, index) {
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
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(value[index].photo))),
                          margin: EdgeInsets.all(8.0),
                          width: 80.0,
                          height: 80.0,
                        ),
                        SizedBox(
                          width: 80.0,
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

    return new Column(
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
          toolbarHeight: 80.0,
          elevation: 0.0,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (page) {
            if (page != 2) {
              _pageController.jumpToPage(page);
              setState(() {
                currentPage = page;
              });
            } else {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => ProfilePage()));
              // logoutUser();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => LoginPage()));
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
        body: PageView(
          controller: _pageController,
          children: [
            SingleChildScrollView(
                child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    print(parsedData.length);
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: parsedData.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 20.0,
                              foregroundImage: NetworkImage(
                                  parsedData[i]['category']['photo']),
                            ),
                            title: Text(
                              '${parsedData[i]['vendor']['businessName']} quoted ₹${parsedData[i]['amount']}',
                              style: GoogleFonts.lato(fontSize: 14.0),
                            ),
                            subtitle: Text(
                              "${parsedData[i]['category']['name']} - ${parsedData[i]['category']['type']}",
                              style: GoogleFonts.lato(fontSize: 12.0),
                            ),
                            trailing: IconButton(
                              color: Colors.teal,
                              iconSize: 30.0,
                              icon: Icon(Icons.phone),
                              onPressed: () {
                                var url = 'tel://' +
                                    parsedData[i]['vendor']['phoneNumber'];
                                _launchURL(url);
                              },
                            ),
                          );
                        });
                  }
                  return CircularProgressIndicator();
                }),
          ],
        ));
  }
}
