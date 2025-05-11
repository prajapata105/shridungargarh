import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/home-screen/homenav.dart';
import '../screens/intro-screen/login-mobile-number.dart';

class Splashservice{
  void isLogin(BuildContext context){
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      WidgetsBinding.instance.addPersistentFrameCallback((_) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeNav(index: 0)));
      });
    } else{
      Get.offAll(const MobileNumber());
      // Future.delayed(const Duration(seconds: 2), () {
      //   Get.offAll(const MobileNumber());
      // });
    }
  }
}
