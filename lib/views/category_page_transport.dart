import 'dart:developer';

import 'package:caruviuserapp/components/toasts/errorToast.dart';
import 'package:caruviuserapp/components/toasts/processing.dart';
import 'package:caruviuserapp/components/toasts/successToast.dart';
import 'package:caruviuserapp/model/CityCategoryModel.dart';
import 'package:caruviuserapp/services/request.service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TransportCategoryPage extends StatefulWidget {
  final CategoryModel category;
  TransportCategoryPage({Key? key, required this.category}) : super(key: key);

  @override
  _TransportCategoryPageState createState() => _TransportCategoryPageState();
}

class _TransportCategoryPageState extends State<TransportCategoryPage> {
  DateTime selectedDate = DateTime.now();
  String calender = "Click to Select Date";
  bool dateSelected = false;
  late String text1;
  String enteredValue = '';
  String enteredValue2 = '';
  String enteredValue3 = '';
  late FToast fToast;
  bool isProcessing = false;
  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  processRequest() async {
    if (enteredValue != '' &&
        enteredValue != '' &&
        !isProcessing &&
        dateSelected) {
      isProcessing = !isProcessing;
      text1 =
          "Need transport from $enteredValue to $enteredValue2 on $calender for $enteredValue3 people";
      Response response =
          await RequestService().sendRequest(widget.category.id, text1);
      // print();

      if (response.statusCode != 201) {
        fToast.showToast(
          child: ErrorToast(
            message: "Opps! Something went wrong.",
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 2),
        );
      } else {
        fToast.showToast(
          child: SuccessToast(
            message: "Your request has been submitted",
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 2),
        );
        Navigator.pop(context);
      }
      isProcessing = !isProcessing;
    } else {
      fToast.showToast(
        child: ErrorToast(
          message: "Enter Valid Number",
        ),
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          snap: false,
          pinned: true,
          floating: false,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text("${widget.category.name}",
                style: GoogleFonts.lato(fontSize: 16.0)),
            background: Stack(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      widget.category.photo,
                    ),
                  ),
                ),
                height: 350.0,
              ),
              Container(
                height: 350.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.teal.withOpacity(0.0),
                          Colors.black54,
                        ],
                        stops: [
                          0.0,
                          1.0
                        ])),
              )
            ]),
          ),
          expandedHeight: 150,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                widget.category.description,
                style: GoogleFonts.lato(height: 1.4),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 100.0),
                    child: TextField(
                      onChanged: (text) {
                        enteredValue = text;
                      },
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.location_on,
                          size: 16.0,
                          color: Colors.teal,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.teal[100]!,
                                style: BorderStyle.solid,
                                width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.teal[100]!,
                                style: BorderStyle.solid,
                                width: 1.0)),
                        hintText: "From",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Icon(
                    Icons.arrow_downward,
                    size: 15.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 100.0),
                    child: TextField(
                      onChanged: (text) {
                        enteredValue2 = text;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "To",
                        prefixIcon: Icon(
                          Icons.location_on,
                          size: 16.0,
                          color: Colors.teal,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.teal[100]!,
                                style: BorderStyle.solid,
                                width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.teal[100]!,
                                style: BorderStyle.solid,
                                width: 1.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Icon(
                    Icons.arrow_downward,
                    size: 15.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 100.0),
                    child: TextField(
                      onChanged: (text) {
                        enteredValue3 = text;
                      },
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Number of People",
                        prefixIcon: Icon(
                          Icons.group,
                          size: 16.0,
                          color: Colors.teal,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.teal[100]!,
                                style: BorderStyle.solid,
                                width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.teal[100]!,
                                style: BorderStyle.solid,
                                width: 1.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Icon(
                    Icons.arrow_downward,
                    size: 15.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 100.0),
                      height: 50.0,
                      alignment: Alignment.center,
                      color: Colors.teal[100],
                      child: Text(
                        calender,
                        style: TextStyle(color: Colors.teal[900]),
                      ),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 200,
                              child: CupertinoDatePicker(
                                minimumDate: DateTime.now(),
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: DateTime.now(),
                                onDateTimeChanged: (DateTime newDateTime) {
                                  // Do something
                                  dateSelected = true;
                                  final DateFormat formatter =
                                      DateFormat('dd-MMM-yy');
                                  String formatted =
                                      formatter.format(newDateTime);

                                  setState(() {
                                    calender = formatted;
                                  });
                                },
                              ),
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Column(
              children: [
                (dateSelected &&
                        enteredValue != '' &&
                        enteredValue2 != '' &&
                        enteredValue3 != '')
                    ? Center(
                        child: SizedBox(
                          width: (MediaQuery.of(context).size.width - 100.0),
                          height: 50.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: isProcessing
                                    ? Colors.teal[100]
                                    : Colors.teal),
                            onPressed: () {
                              processRequest();
                            },
                            child: isProcessing
                                ? SizedBox(
                                    width: 25.0,
                                    height: 25.0,
                                    child: CircularProgressIndicator(
                                      color: Colors.teal[700],
                                      strokeWidth: 2.0,
                                    ),
                                  )
                                : Text(
                                    "Get Quotes",
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        ),
                      )
                    : Center(
                        child: Container(
                          child: Text(
                            "Enter Details to get quotes",
                          ),
                          padding: EdgeInsets.all(10.0),
                        ),
                      )
              ],
            )
          ]),
        )
      ],
    ));
  }
}
