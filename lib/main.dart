// import 'dart:js';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phone_otp/home.dart';
import 'package:phone_otp/otp.dart';
import 'package:phone_otp/phone.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'phone',
    routes: {
      'phone': (context) => Myphone(),
      'otp': (context) => Myotp(),
      'home': (context) =>   Myhome(),
    },

  ));
}


  // This widget is the root of your application.

