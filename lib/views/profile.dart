import 'dart:convert';

import 'package:caruviuserapp/components/service_list_item.dart';
import 'package:caruviuserapp/components/toasts/errorToast.dart';
import 'package:caruviuserapp/components/toasts/processing.dart';
import 'package:caruviuserapp/components/toasts/successToast.dart';
import 'package:caruviuserapp/model/Profile.dart';
import 'package:caruviuserapp/services/auth.service.dart';
import 'package:caruviuserapp/services/user.service.dart';
import 'package:caruviuserapp/views/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late FToast fToast;
  bool isProcessing = false;
  late Profile userProfile;
  late String fullName, phoneNumber, businessName, city, address, emailAddress;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUser();
    fToast = FToast();
    fToast.init(context);
  }

  Future getUser() async {
    Response response = await getMyProfile();

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<String, dynamic>();
      print(parsed);
      this.userProfile = Profile.fromJson(parsed);
      fullNameController.text = this.userProfile.fullName;
      phoneNumberController.text = this.userProfile.phoneNumber;
      businessNameController.text = this.userProfile.businessName;
      businessAddressController.text = this.userProfile.address;
      emailAddressController.text = this.userProfile.emailAddress;
      fullName = this.userProfile.fullName;
      emailAddress = this.userProfile.emailAddress;
      phoneNumber = this.userProfile.phoneNumber;
      businessName = this.userProfile.businessName;
      address = this.userProfile.address;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.teal[900],
              pinned: true,
              floating: true,
              title: Text('Profile'),
              forceElevated: innerBoxIsScrolled,
            ),
          ];
        },
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(bottom: 10.0),
                child: TextField(
                  onChanged: (value) {
                    this.fullName = value;
                  },
                  controller: fullNameController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.teal[50]!,
                              style: BorderStyle.solid,
                              width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green,
                              style: BorderStyle.solid,
                              width: 1.0)),
                      helperText: "Eg: Arjun Bhatt",
                      helperStyle: TextStyle(fontSize: 10.0),
                      labelText: "Your Name"),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: phoneNumberController,
                  onChanged: (value) {
                    this.phoneNumber = value;
                  },
                  decoration: InputDecoration(
                      enabled: false,
                      filled: true,
                      fillColor: Colors.grey[200],
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.teal[50]!,
                              style: BorderStyle.solid,
                              width: 1.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.teal[50]!,
                              style: BorderStyle.solid,
                              width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green,
                              style: BorderStyle.solid,
                              width: 1.0)),
                      helperText: "Eg: 9898989898",
                      helperStyle: TextStyle(fontSize: 10.0),
                      labelText: "Phone Number",
                      prefixText: "+91-"),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(bottom: 10.0),
                child: TextField(
                  onChanged: (value) {
                    this.emailAddress = value;
                  },
                  controller: emailAddressController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.teal[50]!,
                              style: BorderStyle.solid,
                              width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green,
                              style: BorderStyle.solid,
                              width: 1.0)),
                      helperText: "Eg: example@gmail.com",
                      helperStyle: TextStyle(fontSize: 10.0),
                      labelText: "Email Address"),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(bottom: 10.0),
                child: TextField(
                  onChanged: (value) {
                    this.businessName = value;
                  },
                  controller: businessNameController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.teal[50]!,
                              style: BorderStyle.solid,
                              width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green,
                              style: BorderStyle.solid,
                              width: 1.0)),
                      helperText: "Eg: Bhatiya Brothers Electronics",
                      helperStyle: TextStyle(fontSize: 10.0),
                      labelText: "Business Name"),
                ),
              ),
              // Container(
              //   padding: EdgeInsets.all(10.0),
              //   margin: EdgeInsets.only(bottom: 10.0),
              //   child: TextField(
              //     onChanged: (value) {
              //       this.city = value;
              //     },
              //     controller: cityController,
              //     decoration: InputDecoration(
              //         enabled: false,
              //         filled: true,
              //         fillColor: Colors.grey[200],
              //         disabledBorder: OutlineInputBorder(
              //             borderSide: BorderSide(
              //                 color: Colors.teal[50]!,
              //                 style: BorderStyle.solid,
              //                 width: 1.0)),
              //         enabledBorder: OutlineInputBorder(
              //             borderSide: BorderSide(
              //                 color: Colors.teal[50]!,
              //                 style: BorderStyle.solid,
              //                 width: 1.0)),
              //         focusedBorder: OutlineInputBorder(
              //             borderSide: BorderSide(
              //                 color: Colors.green,
              //                 style: BorderStyle.solid,
              //                 width: 1.0)),
              //         helperText: "Eg: Kotdwar",
              //         labelText: "City"),
              //   ),
              // ),

              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(bottom: 10.0),
                child: TextField(
                  maxLines: 8,
                  onChanged: (value) {
                    this.address = value;
                  },
                  minLines: 1,
                  controller: businessAddressController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.teal[50]!,
                              style: BorderStyle.solid,
                              width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green,
                              style: BorderStyle.solid,
                              width: 1.0)),
                      helperText: "Eg: Main market, Kotdwar",
                      helperStyle: TextStyle(fontSize: 10.0),
                      labelText: "Business Address"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                  width: 130.0,
                  height: 40.0,
                  child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          this.isProcessing = !this.isProcessing;
                        });
                        fToast.showToast(
                          child: ProcessingToast(
                            message: "Updating Profile...",
                          ),
                          gravity: ToastGravity.CENTER,
                          toastDuration: Duration(seconds: 1),
                        );
                        Profile updatedProfile = new Profile(
                            address: this.address,
                            banned: userProfile.banned,
                            userType: userProfile.userType,
                            profilePicture: userProfile.profilePicture,
                            lastVisit: userProfile.lastVisit,
                            fullName: this.fullName,
                            emailAddress: this.emailAddress,
                            created: userProfile.created,
                            businessName: this.businessName,
                            phoneNumber: userProfile.phoneNumber,
                            id: userProfile.id);
                        Response response =
                            await updateMyProfile(updatedProfile);
                        if (response.statusCode == 200) {
                          fToast.showToast(
                            child: SuccessToast(
                              message: "Profile Updated",
                            ),
                            gravity: ToastGravity.CENTER,
                            toastDuration: Duration(seconds: 2),
                          );
                        } else {
                          fToast.showToast(
                            child: ErrorToast(
                              message: "Something went wrong",
                            ),
                            gravity: ToastGravity.CENTER,
                            toastDuration: Duration(seconds: 1),
                          );
                        }
                        setState(() {
                          this.isProcessing = !this.isProcessing;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        primary:
                            isProcessing ? Colors.teal[100] : Colors.teal[900],
                      ),
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
                              "Update Profile",
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.white),
                            ))),
              SizedBox(
                height: 50.0,
              ),
              TextButton(
                  onPressed: () {
                    logoutUser();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text("Logout"))
            ],
          ),
        ),
      ),
    );
  }
}
