import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shridungargarh/screens/home-screen/homenav.dart';
import 'package:shridungargarh/screens/intro-screen/splasescreen.dart';
import 'package:shridungargarh/utils/constent.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await MobileAds.instance.initialize();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        )
    );
    return const GetMaterialApp(

      debugShowCheckedModeBanner: false,
      home: SplaseScreen()
    );
  }
}
