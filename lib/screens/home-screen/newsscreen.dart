import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shridungargarh/utils/constent.dart';
import 'package:flutter_tts/flutter_tts.dart';





class Newsscreen extends StatefulWidget {
  var tital,htital,news,image;
   Newsscreen({required this.tital, required this.htital, required this.news,required this.image});

  @override
  State<Newsscreen> createState() => _NewsscreenState();
}

class _NewsscreenState extends State<Newsscreen> {
  var size,w,h;
  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;
  bool audio = false;
  final FlutterTts  flutterTts  = FlutterTts();


  @override
  void initState() {
    super.initState();
    _createBottomBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    _bottomBannerAd.dispose();
  }
  @override
  void deactivate() {
    super.deactivate();
    flutterTts.stop();

  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: InkWell(
           onTap: (){
             Get.back();
           },
          child: Icon(
            Icons.arrow_back_sharp,
            color: ksubprime,
          ),
        ),
        title: Text(
          " Breaking News",
          style: TextStyle(color: ksubprime),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: h*0.3,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),image: DecorationImage(image: NetworkImage(widget.image.toString(),),fit: BoxFit.fill)),
                ),
                SizedBox(
                  height: h*0.01,
                ),
                // Text("2022-09-09T07:46:01Z"),
                //titla
                Text(
                  widget.tital,
                  style: TextStyle(fontSize: h*0.035, fontWeight: FontWeight.bold,color: ksubprime),
                ),
                SizedBox(
                  height: h*0.01,
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      audio ?  flutterTts.pause() : speak();
                      audio = !audio;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: h*0.06,
                    width: w*1,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                            color: kPrimaryColor,
                            offset: Offset(0, 0),
                            blurRadius: 01,
                            spreadRadius: 0.03,
                          )
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Color(0xfff9cdc3),
                            Color(0xfffacefb),
                           // Color(0xff5FFBF1),
                          ],
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/imagesvg/speacker.png',height: h*0.04),
                        Text('यह खबर हिंदी में सुनिए',style: TextStyle(color: Color(0xff243748),fontWeight: FontWeight.bold,fontSize: 20),),
                    Icon(audio ? Icons.pause_circle :Icons.play_circle,),

                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: h*0.015,
                ),
                Text(widget.htital,style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: h*0.015,
                ),

                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: _bottomBannerAd.size.height.toDouble(),
                    width:  _bottomBannerAd.size.width.toDouble(),
                    child: AdWidget(ad: _bottomBannerAd),
                  ),
                ),
                Text(widget.news,style: TextStyle(fontSize: 20),)
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _createBottomBannerAd(){
    _bottomBannerAd = BannerAd(
      adUnitId: 'ca-app-pub-9490799633031429/2524033128',
      size: AdSize.mediumRectangle,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBottomBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bottomBannerAd.load();
  }
  speak()async {
   await flutterTts.setLanguage('hi');
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.speak(widget.news);
  }
}
