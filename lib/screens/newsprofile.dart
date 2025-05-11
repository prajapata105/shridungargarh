import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:shridungargarh/utils/constent.dart';
import 'package:get/get.dart';

import 'home-screen/newsscreen.dart';
const int maxFailedLoadAttempts = 3;
class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int _interstitialLoadAttempts = 0;
  final ScrollController _controller = ScrollController();
  var size,w,h;
  late BannerAd bannerAd;
  final String adunitId = "ca-app-pub-9490799633031429/9055843969";
  InterstitialAd? _interstitialAd;
  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;


  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
    _createBottomBannerAd();
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
    return Container(
      color: kBackgroundColor,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "ताज़ा खबर",
                  style: TextStyle(
                      color: kBlackColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('newsbanner').snapshots(), builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.active) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return CarouselSlider.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                        Map<String, dynamic> bannners = snapshot.data!.docs[itemIndex].data() as Map<String, dynamic>;
                        return  Container(
                          margin: EdgeInsets.all(5),
                          width: w * 0.8,
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
                        autoPlay: true,
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
              SizedBox(height: h*0.01,),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(5),
                width: w * 0.92,
                height: h*0.07,
                decoration: BoxDecoration(
                    color: kBlackColor,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                          color: kWhiteColor.withOpacity(0.20),
                          spreadRadius: 2,
                          blurRadius: 4),
                    ],
                ),
                child: _isBottomBannerAdLoaded ? AdWidget(ad: _bottomBannerAd,) : null,
              ),
              SizedBox(height: h*0.01,),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('news').orderBy('time', descending:true).snapshots(), builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.active) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return ListView.builder(
                        controller: _controller,
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          Map<dynamic, dynamic> newslist = snapshot.data!.docs[index].data() as Map<dynamic, dynamic>;
                          Timestamp  t = newslist['time'] as Timestamp;
                          DateTime date = t.toDate();

                          return InkWell(
                            onTap: (){
                              _showInterstitialAd();
                              Get.to(Newsscreen(image: newslist['image'],htital: newslist['htital'],news: newslist['news'],tital: newslist['tital'],));
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
                              height: h * 0.14,
                              width: w * 01,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: kWhiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: kPrimaryColor.withOpacity(0.1),
                                      blurRadius: 7,
                                      spreadRadius: 5,
                                      offset: Offset(1, 1),
                                    )
                                  ]),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: h * 0.15,
                                    width: w * 0.32,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: kPrimaryColor,
                                        image: DecorationImage(
                                            image: NetworkImage(newslist['image']),
                                            fit: BoxFit.fill)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(h*0.01),
                                    height: h * 0.1,
                                    width: w * 0.53,
                                    child: Text(newslist['tital'],
                                      style: TextStyle(
                                          color: ksubprime,
                                          fontWeight: FontWeight.bold,
                                          fontSize: h*0.022),
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
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
            ],
          ),
        ),
      )),
    );
  }
  final BannerAdListener bannerAdListener = BannerAdListener(
      onAdLoaded: (Ad ad) {
        print('load');
      },
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
        print('Ad fiald to load $error');
      },
      onAdOpened: (Ad ad) {
        print('open add');
      }
  );

  void _createInterstitialAd(){
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-9490799633031429/2835896459',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialLoadAttempts += 1;
          _interstitialAd = null;
          if(_interstitialLoadAttempts <= maxFailedLoadAttempts){
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
  void _createBottomBannerAd(){
    _bottomBannerAd = BannerAd(
      adUnitId: 'ca-app-pub-9490799633031429/2524033128',
      size: AdSize.banner,
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

}