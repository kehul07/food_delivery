import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery/pages/bottom_nav.dart';
import 'package:food_delivery/pages/onboard.dart';
import 'package:food_delivery/services/auth_method.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),(){
        AuthMethod().isLoggedin().then((value){
          if(value){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (contetx)=>BottomNav()));
          }else{
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (contetx)=>Onboard()));
          }
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child:Image.asset("images/logo.png",width: MediaQuery.of(context).size.width/1.5,)
      ),
    );
  }
}
