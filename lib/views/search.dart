import 'dart:convert';

import 'package:caruviuserapp/model/CityCategoryModel.dart';
import 'package:caruviuserapp/services/city.service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'category_page.dart';
import 'category_page_transport.dart';

class SearchPage extends StatefulWidget {
  final String term;
  SearchPage({Key? key, required this.term}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int count = 0;
  @override
  @override
  void initState() {
    super.initState();
  }

  Future getResult() async {
    var response = await CityService().searchCategory(widget.term);
    var parsed = jsonDecode(response.body);
    setState(() {
      count = parsed.length;
    });
    return response;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Search Result for \'${widget.term}\''),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              alignment: Alignment.center,
              color: Colors.teal[500],
              child: Column(
                children: [
                  Text(
                    "${count} ${count > 1 ? "Results" : "Result"} for term ${widget.term}",
                    style:
                        GoogleFonts.lato(fontSize: 14.0, color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            FutureBuilder(
                future: getResult(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var response = snapshot.data;
                    var parsed = jsonDecode(response.body);
                    if (parsed.length > 0) {
                      return ListView.builder(
                          itemCount: parsed.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index) {
                            CategoryModel category =
                                CategoryModel.fromJson(parsed[index]);
                            return GestureDetector(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        child: Image.network(
                                          category.photo,
                                          width: double.infinity,
                                          height: 130.0,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0)),
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
                                                    category.name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.lato(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Text(
                                                    category.description,
                                                    style: GoogleFonts.lato(
                                                        height: 1.4,
                                                        fontSize: 12.0,
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
                                                      BorderRadius.circular(
                                                          8.0)),
                                              padding: EdgeInsets.all(10.0),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.remove_red_eye_outlined,
                                                  size: 16.0,
                                                  color: Colors.teal[500],
                                                ),
                                                onPressed: () {
                                                  if (category.type ==
                                                      'Transport') {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                TransportCategoryPage(
                                                                  category:
                                                                      category,
                                                                )));
                                                  } else {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                CategoryPage(
                                                                  category:
                                                                      category,
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
                                ),
                                onTap: () {
                                  if (category.type == 'Transport') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TransportCategoryPage(
                                                  category: category,
                                                )));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CategoryPage(
                                                  category: category,
                                                )));
                                  }
                                });
                          });
                    } else {
                      // TODO: Nothing found;
                    }
                  }
                  return Center(
                    child: Text("Searching ..."),
                  );
                }),
          ],
        )));
  }
}
