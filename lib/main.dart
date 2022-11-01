import 'dart:async';

import 'package:basalt_assessment/reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'offline_screen.dart';





void main() {
  runApp(ProviderScope(child: const MyApp()));
}




class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

bool connected = true;
  @override
  void initState() {
    checkConnection();
    Timer.periodic(Duration(seconds: 10), (timer) {
      checkConnection();
    });
    super.initState();
  }

  checkConnection()async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      setState(() {
        connected = true;
      });
    } else {
      setState(() {
        connected = false;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return
      OverlaySupport.global(
        child:MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:connected? Reports():OfflineScreen(),
    ));
  }
}


