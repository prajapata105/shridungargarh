import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shridungargarh/screens/home-screen/mobilenumber.dart';
import 'package:shridungargarh/screens/home-screen/newsupdate.dart';
import 'package:shridungargarh/utils/constent.dart';
import 'package:url_launcher/url_launcher.dart';
import 'homenav.dart';
const int maxFailedLoadAttempt = 3;
class FirstPage extends StatefulWidget {
   FirstPage({Key? key}) : super(key: key);
  static bool openlist = true;


  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int _interstitialLoadAttempts = 0;
  ScrollController _controller = ScrollController();
  final CarouselController controller = CarouselController();
  final auth = FirebaseAuth.instance;
  InterstitialAd? _interstitialAd;
  var inst = FirebaseFirestore.instance;
  var newarray;
  var size,w,h;
  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
    _bottomBannerAd.dispose();
  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kWhiteColor,
        elevation: 0,
        title: InkWell(
          onTap: (){
            Get.to(Newsupdate());
          },
          child: Text(
            'श्री डूँगरगढ़ one',
            style: TextStyle(
              color: ksubprime,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance .collection('homepage').snapshots(), builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.active) {
                if (snapshot.hasData && snapshot.data != null) {
                  return
                    CarouselSlider.builder(
                    carouselController: controller,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                      Map<String, dynamic> bannners = snapshot.data!.docs[itemIndex].data() as Map<String, dynamic>;
                      return  Container(
                        margin: EdgeInsets.all(5),
                        width: w *0.9,
                        decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: kWhiteColor.withOpacity(0.20),
                                  spreadRadius: 2,
                                  blurRadius: 4),
                            ],
                            image: DecorationImage(
                                image: NetworkImage(bannners['banner']),
                                fit: BoxFit.fill)),
                      );
                    },
                    options: CarouselOptions(
                      height: h * 0.23,
                      viewportFraction: 1,
                      initialPage: 0,
                      scrollPhysics: snapshot.data!.docs.length == 1 ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics(),
                      autoPlay: snapshot.data!.docs.length == 1 ? false : true,
                      autoPlayAnimationDuration: Duration(seconds: 2),
                      autoPlayInterval: Duration(seconds: 25),
                    ),
                  );

                } else {
                  return Text('data not found');
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),

            SizedBox(
              height: h * 0.02,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: w * 0.01),
              padding: EdgeInsets.only(
                  left: w * 0.04,
                  right: w * 0.03,
                  bottom: h * 0.01,
                  top: h * 0.02),
              width: w * 1,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'श्रेणी के अनुसार खोजें',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('mobilenumber').snapshots(), builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.active) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return
                              GridView.builder(
                                controller: _controller,
                                shrinkWrap: true,
                                itemCount:  FirstPage.openlist ? 8 : snapshot.data!.docs.length,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: h * 0.002,
                                    childAspectRatio: 0.7,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  Map<String, dynamic> mobile = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                                  return Container(
                                    height: h * 0.15,
                                    width: w * 0.25,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            _showInterstitialAd();
                                            Get.to(MobileNumbers(id: snapshot.data!.docs[index].id,cate: mobile['cate'],),transition: Transition.zoom,duration: Duration(milliseconds: 200));
                                          },
                                          child: Container(
                                            height: h * 0.085,
                                            width: w * 0.177,
                                            padding: EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xffe3ffe7),
                                                  Color(0xffd9e7ff),
                                                ],
                                              ),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Image.network(
                                              mobile['image'],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                          EdgeInsets.only(top: h * 0.004),
                                          alignment: Alignment.topCenter,
                                          //  height: h * 0.05,
                                          width: w * 0.3,
                                          child: Text(
                                            mobile['cate'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: ksubprime.withOpacity(0.80),
                                                fontWeight: FontWeight.bold,
                                              fontSize: h*0.02
                                            ),
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });

                          } else {
                            return Text('data not found');
                          }
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                  InkWell(
                    onTap: (){
                      setState(() {
                        FirstPage.openlist= !FirstPage.openlist;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: h*0.05,
                      width: w*09,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kGreyColor,
                        ),
                         gradient: LinearGradient(
                          colors: [
                          Color(0xffe3ffe7),
                      Color(0xffd9e7ff),
                      ],
                    ),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text( FirstPage.openlist ? 'और मोबाइल नंबर देखें' : "बंद करें",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: ksubprime),),
                          FirstPage.openlist ? Icon(Icons.keyboard_arrow_down_sharp) : Icon(Icons.keyboard_arrow_up_outlined)
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: w * 0.01),
              padding: EdgeInsets.only(
                  left: w * 0.04,
                  right: w * 0.03,
                  bottom: h * 0.01,
                  top: h * 0.02),
              child: Row(
                children: [
                  Expanded(
                    child:
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeNav(index: 1)));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: w*0.01),
                        height: h*0.08,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xffD16BA5),
                                Color(0xff86A8E7),
                                Color(0xff5FFBF1),
                              ],
                            )
                        ),
                        child: Text(' ताज़ा ख़बर देखे',style: TextStyle(color: kWhiteColor, fontSize:h*0.03,fontWeight: FontWeight.bold,)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeNav(index: 3)));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: w*0.01),
                        height: h*0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xffD16BA5),
                                Color(0xff86A8E7),
                                Color(0xff5FFBF1),
                              ],
                            )
                        ),
                        child: Text('आज का मंडी भाव',style: TextStyle(color: kWhiteColor, fontSize:h*0.03,fontWeight: FontWeight.bold,)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('A4banner').snapshots(), builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.active) {
                if (snapshot.hasData && snapshot.data != null) {
                  return snapshot.data!.docs.isNotEmpty ?
                  CarouselSlider.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                      Map<String, dynamic> bannners = snapshot.data!.docs[itemIndex].data() as Map<String, dynamic>;
                      return    InkWell(
                        onTap: () async{
                          var whatsappUrl = bannners['url'];
                          await canLaunch(whatsappUrl) != null
                              ?launch(whatsappUrl)
                              : print(
                              "open WhatsApp app link or do a snackbar with notification that there is no WhatsApp installed");
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: w * 0.02,vertical: h*0.01),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kCyanColor,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5),bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5)),
                              image: DecorationImage(
                                  image: NetworkImage(bannners['banner'],),fit: BoxFit.fill
                              )
                          ),

                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: h*0.6,
                      viewportFraction: 1,
                      autoPlayAnimationDuration: Duration(seconds: 2),
                      autoPlayInterval: Duration(seconds: 20),
                      autoPlay: true,
                    ),
                  ) : Container();

                } else {
                  return Text('data not found');
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
  void _createInterstitialAd(){
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-9490799633031429/4182150604',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialLoadAttempts += 1;
          _interstitialAd = null;
          if(_interstitialLoadAttempts <= maxFailedLoadAttempt){
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  void _showInterstitialAd(){
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      _interstitialAd!.show();
    }
  }


}
