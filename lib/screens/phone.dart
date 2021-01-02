import 'dart:ui';
import 'package:Trampo/constants/colorConstant.dart';
import '../constants/loginclipper.dart';
import '../providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class PhoneAuthentication extends StatefulWidget {
  static const routeName = '/phone';
  @override
  _PhoneAuthenticationState createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  int state = 1;
  String dropdownValue = '(+91)   India';
  PhoneAuthCredential credential;
  PhoneAuthCredential phoneAuthCredential;
  final _phonenumber = TextEditingController();
  final _phonenode = FocusNode();
  String code;
  String id;
  final key = GlobalKey<FormFieldState>();
  final _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Container(
        //padding: EdgeInsets.all(20),
        //margin: EdgeInsets.all(20),
        height: double.infinity,

        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomRight,
              colors: [Color(0xFF2B39D1), kprimaryColor]),
        ),
        child: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ClipPath(
                  clipper: LoginClipper(),
                  child: Container(
                    color: Colors.white,
                    height: h * 0.55,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Text(
                          'Phone Authentication',
                          style: Theme.of(context).textTheme.headline1.copyWith(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Lato',
                              ),
                        ),
                        Text(
                          'To get Shia Updates Regularly',
                          style: Theme.of(context).textTheme.headline2.copyWith(
                                fontSize: 16.0,
                                fontFamily: 'Lato',
                              ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Image(
                          image: AssetImage('assests/truck.png'),
                          height: 100,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          state == 1
                              ? 'Enter Your Mobile Number'
                              : 'Enter The OTP sent to you',
                          style: Theme.of(context).textTheme.headline1.copyWith(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Lato',
                              ),
                        ),
                        Text(
                          state == 1
                              ? 'We will send you a OTP Message'
                              : 'Check your inbox you would have received a OTP',
                          style: Theme.of(context).textTheme.headline2.copyWith(
                                fontSize: 12.0,
                                fontFamily: 'Lato',
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  dropdownColor: Colors.black54,
                  icon: Icon(
                    Icons.expand_more_sharp,
                    color: Colors.white,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  underline: Container(
                    height: 1,
                    color: Colors.white,
                  ),
                  style: TextStyle(color: Colors.white),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  //isExpanded: true,
                  items: [
                    '(+91)   India',
                    '(+61)    Australia',
                    '(+1)   Canada',
                    '(+86)    China',
                    '(+98)    Iran',
                    '(+964)   Iraq',
                    '(+972)   Israel',
                    '(+92)    Pakistan',
                    '(+966)   Saudi Arabia',
                    '(+971)   United Arab Emirates',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: TextField(
                    cursorColor: Colors.white,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                    controller: _phonenumber,
                    focusNode: _phonenode,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Mobile Number',
                      hintStyle: TextStyle(
                        color: Colors.white70,
                        fontFamily: 'Lato',
                      ),
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
                      //contentPadding: EdgeInsets.symmetric(horizontal: 50),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 1.0),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 1.0),
                      ),
                    ),
                  ),
                ),
                if (state == 2)
                  SizedBox(
                    height: 20,
                  ),
                if (state == 2)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: PinPut(
                      key: key,
                      fieldsCount: 6,
                      validator: (val) {
                        if (val.length != 6) return 'Enter The OTP';
                      },
                      onSubmit: (String pin) {
                        setState(() {
                          code = pin;
                        });
                      },
                      textStyle: TextStyle(color: Colors.white),
                      focusNode: _pinPutFocusNode,
                      controller: _pinPutController,
                      submittedFieldDecoration: _pinPutDecoration.copyWith(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      selectedFieldDecoration: _pinPutDecoration,
                      followingFieldDecoration: _pinPutDecoration.copyWith(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: 12,
                ),
                if (state == 1)
                  RaisedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance
                          .verifyPhoneNumber(
                        phoneNumber: '+91${_phonenumber.text}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) async {
                          print('verification');
                          await Provider.of<Auth>(context, listen: false)
                              .authlogin(credential);
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          if (e.code == 'invalid-phone-number') {
                            print('The provided phone number is not valid.');
                          }
                        },
                        codeSent:
                            (String verificationId, int resendToken) async {
                          print('entered');
                          setState(() {
                            id = verificationId;
                          });
                          print(id);
                        },
                        timeout: const Duration(seconds: 120),
                        codeAutoRetrievalTimeout: (String verificationId) {
                          print('Time-out');
                        },
                      )
                          .whenComplete(() {
                        setState(() {
                          state = 2;
                        });
                      });
                    },
                    child: Text('Send OTP'),
                    //colorBrightness: Brightness.dark,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white)),
                  ),
                if (state == 2)
                  RaisedButton(
                    onPressed: () async {
                      print(id);
                      print(code);
                      phoneAuthCredential = PhoneAuthProvider.credential(
                        verificationId: id,
                        smsCode: _pinPutController.text,
                      );

                      print((_pinPutController.text).runtimeType);
                      await Provider.of<Auth>(context, listen: false)
                          .authlogin(phoneAuthCredential);
                    },
                    child: Text('Verify'),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white)),
                  ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      state = 1;
                    });
                  },
                  child: Text(
                    'back',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
