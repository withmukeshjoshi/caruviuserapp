import 'package:cached_network_image/cached_network_image.dart';
import 'package:caruviuserapp/components/toasts/errorToast.dart';
import 'package:caruviuserapp/components/toasts/processing.dart';
import 'package:caruviuserapp/components/toasts/successToast.dart';
import 'package:caruviuserapp/model/CityCategoryModel.dart';
import 'package:caruviuserapp/services/request.service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:overlay_support/overlay_support.dart';

class CategoryPage extends StatefulWidget {
  final CategoryModel category;
  CategoryPage({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late String text1;
  late String text2;
  String enteredValue = '';
  late FToast fToast;
  bool isProcessing = false;
  @override
  void initState() {
    text1 = "I am looking for ";
    text2 = " of ${widget.category.name.toLowerCase()}";
    generateText();
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  generateText() {
    if (widget.category.nature == "Service") {
      text1 = "I need ${widget.category.name.toLowerCase()} service for ";
      text2 = " ";
    }
  }

  processRequest() async {
    if (enteredValue != '' && !isProcessing) {
      isProcessing = !isProcessing;
      Response response = await RequestService().sendRequest(widget.category.id,
          text1 + enteredValue + " " + widget.category.value + text2);
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
        showSimpleNotification(Text("Your request has been submitted"),
            background: Colors.green, leading: Icon(Icons.check));
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
                    image: CachedNetworkImageProvider(
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
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Fill the details to get best quotes",
                  style: GoogleFonts.lato(
                      height: 1.4,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                      color: Colors.teal[500]),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    text1,
                    style: GoogleFonts.lato(
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0),
                  ),
                ),
                SizedBox(
                  width: 200.0,
                  child: TextField(
                    onChanged: (text) {
                      enteredValue = text;
                    },
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      suffix: Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Text(
                          widget.category.value,
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.teal[400],
                        padding: EdgeInsets.all(5.0),
                      ),
                      hintText: "Enter Number",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    text2,
                    style: GoogleFonts.lato(
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 150.0,
                    height: 45.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary:
                              isProcessing ? Colors.teal[100] : Colors.teal),
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
              ],
            )
          ]),
        )
      ],
    ));
  }
}
