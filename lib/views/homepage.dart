import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarColor: Colors.transparent, // Status bar
          ),
          actions: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.asset(
                  'assets/splash.png',
                  width: 50.0,
                ))
          ],
          title: Row(
            children: [
              Icon(Icons.location_on_outlined, color: Colors.green[600]),
              SizedBox(
                width: 5.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Roorkee",
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                        color: Colors.green[600]),
                  ),
                  Text(
                    "Showing all services near you",
                    style:
                        TextStyle(fontSize: 12.0, color: Colors.blueGrey[800]),
                  ),
                ],
              )
            ],
          ),
          backgroundColor: Colors.green[100],
          toolbarHeight: 80.0,
          elevation: 0.0,
        ),
        backgroundColor: Colors.green[50],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: "Requests"),
          ],
          enableFeedback: true,
          selectedItemColor: Colors.green[800],
          elevation: 1.0,
        ),
        body: SingleChildScrollView(
            child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 25.0,
              ),
              Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Agriculture",
                    style: GoogleFonts.lato(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  )),
              Wrap(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://images.unsplash.com/photo-1555353540-64580b51c258?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=678&q=80'))),
                        margin: EdgeInsets.all(10.0),
                        width: 80.0,
                        height: 80.0,
                      ),
                      Text(
                        "Car Service",
                        style: TextStyle(fontSize: 12.0),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://media.istockphoto.com/photos/close-up-various-fresh-picked-mushrooms-on-wood-board-picture-id1273246946?b=1&k=20&m=1273246946&s=170667a&w=0&h=Jrj7ovrblsPm6U813xoOYncu4-BlCb8-L0GNbRPiQ8I='))),
                        margin: EdgeInsets.all(8.0),
                        width: 80.0,
                        height: 80.0,
                      ),
                      Text(
                        "Mushroom",
                        style: TextStyle(fontSize: 12.0),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://images.unsplash.com/photo-1605469237567-a39930679526?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1170&q=80'))),
                        margin: EdgeInsets.all(8.0),
                        width: 80.0,
                        height: 80.0,
                      ),
                      Text(
                        "Dhoopbatti",
                        style: TextStyle(fontSize: 12.0),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Personal Care",
                    style: GoogleFonts.lato(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  )),
              Wrap(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://images.unsplash.com/photo-1555353540-64580b51c258?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=678&q=80'))),
                        margin: EdgeInsets.all(10.0),
                        width: 80.0,
                        height: 80.0,
                      ),
                      Text(
                        "Blood Test",
                        style: TextStyle(fontSize: 12.0),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://media.istockphoto.com/photos/close-up-various-fresh-picked-mushrooms-on-wood-board-picture-id1273246946?b=1&k=20&m=1273246946&s=170667a&w=0&h=Jrj7ovrblsPm6U813xoOYncu4-BlCb8-L0GNbRPiQ8I='))),
                        margin: EdgeInsets.all(8.0),
                        width: 80.0,
                        height: 80.0,
                      ),
                      Text(
                        "Lipid Test",
                        style: TextStyle(fontSize: 12.0),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://images.unsplash.com/photo-1605469237567-a39930679526?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1170&q=80'))),
                        margin: EdgeInsets.all(8.0),
                        width: 80.0,
                        height: 80.0,
                      ),
                      Text(
                        "Health Checkup",
                        style: TextStyle(fontSize: 12.0),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Other Services",
                    style: GoogleFonts.lato(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  )),
              Wrap(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://images.unsplash.com/photo-1555353540-64580b51c258?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=678&q=80'))),
                        margin: EdgeInsets.all(10.0),
                        width: 80.0,
                        height: 80.0,
                      ),
                      Text(
                        "Hotel Room",
                        style: TextStyle(fontSize: 12.0),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://media.istockphoto.com/photos/close-up-various-fresh-picked-mushrooms-on-wood-board-picture-id1273246946?b=1&k=20&m=1273246946&s=170667a&w=0&h=Jrj7ovrblsPm6U813xoOYncu4-BlCb8-L0GNbRPiQ8I='))),
                        margin: EdgeInsets.all(8.0),
                        width: 80.0,
                        height: 80.0,
                      ),
                      Text(
                        "Home Cleaning",
                        style: TextStyle(fontSize: 12.0),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://images.unsplash.com/photo-1605469237567-a39930679526?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1170&q=80'))),
                        margin: EdgeInsets.all(8.0),
                        width: 80.0,
                        height: 80.0,
                      ),
                      Text(
                        "Legal Advice",
                        style: TextStyle(fontSize: 12.0),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Recently Viewed",
                    style: GoogleFonts.lato(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.green[100]!),
                              borderRadius: BorderRadius.circular(4.0)),
                          padding: EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 25.0),
                          child: Text("Car Service"),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.green[100]!),
                              borderRadius: BorderRadius.circular(4.0)),
                          padding: EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 25.0),
                          child: Text("Mushroom"),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.green[100]!),
                              borderRadius: BorderRadius.circular(4.0)),
                          padding: EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 25.0),
                          child: Text("Dhoopbatti"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
        )));
  }
}
