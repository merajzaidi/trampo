import 'package:Trampo/providers/auth.dart';
import 'package:Trampo/screens/HomePage_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

enum AuthMode {
  Login,
  Signup,
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthMode _authMode;
  final _phonenumber = TextEditingController();
  final _phonenode = FocusNode();
  var _isLoading = false, verify = false;
  var phoneno = '', code = '';
  final _codetext = TextEditingController();
  final codenode = FocusNode();
  PhoneAuthCredential credential;
  PhoneAuthCredential phoneAuthCredential;
  String id;
  @override
  Widget build(BuildContext context) {
    _authMode = AuthMode.Login;
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Image(image: AssetImage('assests/login.jpg')),
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _authMode == AuthMode.Login ? 'Login' : 'SignUp',
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Castoro',
                      ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: FlatButton(
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Verify',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          verify = true;
                        });
                        print(verify);
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: '+91${_phonenumber.text}',
                          verificationCompleted:
                              (PhoneAuthCredential credential) async {
                            await Provider.of<Auth>(context, listen: false)
                                .authlogin(credential);
                          },
                          verificationFailed: (FirebaseAuthException e) {
                            if (e.code == 'invalid-phone-number') {
                              print('The provided phone number is not valid.');
                            }
                            if (e.code == 'invalid-verification-id') {
                              print('invalid-verification-id');
                            }
                          },
                          codeSent:
                              (String verificationId, int resendToken) async {
                            setState(() {
                              phoneAuthCredential =
                                  PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: _codetext.text,
                              );
                              setState(() {
                                id = verificationId;
                              });
                            });
                          },
                          timeout: const Duration(seconds: 120),
                          codeAutoRetrievalTimeout: (String verificationId) {
                            print('Time-out');
                          },
                        );
                      },
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    // hintText: 'email',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  validator: (value) {
                    if (value.length != 10) return 'Invalid Phone Number';
                  },
                  onSaved: (value) {
                    phoneno = value;
                  },
                  controller: _phonenumber,
                  focusNode: _phonenode,
                  keyboardType: TextInputType.phone,
                ),
                verify
                    ? const SizedBox(
                        height: 13.0,
                      )
                    : SizedBox(),
                verify
                    ? TextFormField(
                        decoration: InputDecoration(
                          fillColor: Theme.of(context).accentColor,
                          //filled: true,
                          // hintText: 'email',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black45, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        controller: _codetext,
                        //obscureText: true,
                        onSaved: (val) => code = val,
                        focusNode: codenode,
                      )
                    : SizedBox(),
                RaisedButton(
                  onPressed: () async {
                    phoneAuthCredential = PhoneAuthProvider.credential(
                      verificationId: id,
                      smsCode: _codetext.text,
                    );
                    await Provider.of<Auth>(context, listen: false)
                        .authlogin(phoneAuthCredential);
                  },
                  child: Text('submit'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
