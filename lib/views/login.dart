import 'package:caruviuserapp/components/toasts/errorToast.dart';
import 'package:caruviuserapp/config/static.dart';
import 'package:caruviuserapp/services/auth.service.dart';
import 'package:caruviuserapp/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String loginPhoneNumber = '';
  String loginPassword = '';
  late FToast fToast;
  bool isProcessing = false;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/splash.png'),
                        fit: BoxFit.scaleDown)),
                width: double.infinity,
                height: 250.0,
              ),
              Padding(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      loginPageTitle,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      loginPageSubtitle,
                      style: TextStyle(color: Colors.black26),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        loginPhoneNumber = value;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFF3F8ED),
                          filled: true,
                          prefixText: "+91-",
                          labelText: "Phone Number",
                          hintText: "0000000000",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black12,
                                  style: BorderStyle.solid,
                                  width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green,
                                  style: BorderStyle.solid,
                                  width: 1.0))),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          loginPassword = value;
                        });
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          labelText: "Password",
                          fillColor: Color(0xFFF3F8ED),
                          filled: true,
                          hintText: "Password",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black12,
                                  style: BorderStyle.solid,
                                  width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green,
                                  style: BorderStyle.solid,
                                  width: 1.0))),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            primary: isProcessing
                                ? Colors.teal[100]
                                : Colors.teal[900],
                          ),
                          onPressed: () async {
                            try {
                              if (loginPhoneNumber != '' &&
                                  loginPassword != '') {
                                setState(() {
                                  isProcessing = !isProcessing;
                                });
                                var auth = await authenticateuser(
                                    phoneNumber: loginPhoneNumber,
                                    password: loginPassword);
                                if (auth) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                } else {
                                  fToast.showToast(
                                    child: ErrorToast(
                                      message: "Something went wrong",
                                    ),
                                    gravity: ToastGravity.BOTTOM,
                                    toastDuration: Duration(seconds: 1),
                                  );
                                }
                                setState(() {
                                  isProcessing = !isProcessing;
                                });
                              } else {
                                fToast.showToast(
                                  child: ErrorToast(
                                    message: "Enter Valid Credentials",
                                  ),
                                  gravity: ToastGravity.BOTTOM,
                                  toastDuration: Duration(seconds: 1),
                                );
                              }
                            } catch (err) {
                              print(err);
                              setState(() {
                                isProcessing = !isProcessing;
                              });
                              fToast.showToast(
                                child: ErrorToast(
                                  message: "Something went wrong",
                                ),
                                gravity: ToastGravity.BOTTOM,
                                toastDuration: Duration(seconds: 1),
                              );
                            }
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
                              : Text("Login")),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
