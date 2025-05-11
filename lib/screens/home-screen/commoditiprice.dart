import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shridungargarh/utils/constent.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:photo_view/photo_view.dart';
import '../../model/mobiledetails.dart';

class CommoditiPrice extends StatefulWidget {
  const CommoditiPrice({Key? key}) : super(key: key);

  @override
  State<CommoditiPrice> createState() => _CommoditiPriceState();
}

class _CommoditiPriceState extends State<CommoditiPrice> {
  ScrollController _controller = ScrollController();
  var size, w, h;
  List<MandiBhav> mandiprice = [];
  List<Mobiledetails> mobilenumberdatas = [];
  late BannerAd bannerAd;
  final String adunitId = "ca-app-pub-9490799633031429/6465339644";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getmandiprice();
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: adunitId,
        listener: bannerAdListener,
        request: const AdRequest());
    bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(ad: bannerAd);
    size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding:
                EdgeInsets.symmetric(vertical: h * 0.00, horizontal: w * 0.004),
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color(0xffA1C4FD),
                Color(0xffC2E9FB),
              ],
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/imagesvg/namste.png',
                  height: h * 0.1,
                ),
                Text(
                  'नमस्ते ',
                  style: TextStyle(
                    color: ksubprime,
                    fontWeight: FontWeight.bold,
                    fontSize: h * 0.04,
                  ),
                ),
                Text(
                  'श्री डूंगरगढ़ के मंडी भाव',
                  style: TextStyle(fontSize: h * 0.03),
                ),
                SizedBox(
                  height: h * 0.01,
                ),
                Container(
                    padding: EdgeInsets.symmetric(vertical: h * 0.01, horizontal: w * 0.03),
                    width: w * 1,
                    decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30))),
                    child: Column(
                      children: [
                        // Container(
                        //   padding: EdgeInsets.all(10),
                        //     decoration: BoxDecoration(
                        //         gradient: LinearGradient(
                        //           colors: [
                        //             Color(0xffA1C4FD),
                        //             Color(0xffC2E9FB),
                        //           ],
                        //         ),
                        //         borderRadius: BorderRadius.circular(10)),
                        //     child: Text(
                        //       'Date :  20/02/2022',
                        //       style: TextStyle(color: ksubprime, fontSize: 20),
                        //     )),
                        SizedBox(
                          height: h * 0.01,
                        ),
                        GridView.builder(
                            controller: _controller,
                            shrinkWrap: true,
                            itemCount: mandiprice.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: h * 0.02,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 10,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return mandiprice.isEmpty ? CircularProgressIndicator():  Container(
                                padding: EdgeInsets.all(5),
                                  width: w * 0.004,
                                  decoration: BoxDecoration(
                                      color: kWhiteColor,
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          //color of shadow
                                          spreadRadius: 5,
                                          //spread radius
                                          blurRadius: 7,
                                          // blur radius
                                          offset: Offset(0, 2),
                                        )
                                      ]),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: h*0.01),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          color: kPrimaryColor,
                                          image: DecorationImage(
                                            image: NetworkImage(mandiprice[index].image.toString()),fit: BoxFit.fill
                                          )
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                        ),
                                        child: Column(
                                          children: [
                                            Text(mandiprice[index].name.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                            Divider(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text('कम कीमत',style: TextStyle(fontSize: 15,color: kGreyColor,fontWeight: FontWeight.w600)),
                                                Text('ज्यादा कीमत',style: TextStyle(fontSize: 15,color: kGreyColor,fontWeight: FontWeight.w600))
                                              ],
                                            ),
                                            SizedBox(height: h*0.01,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text('₹${mandiprice[index].low.toString()}',style: TextStyle(fontSize: 15,color: Colors.red,fontWeight: FontWeight.w600)),
                                                Text('₹${mandiprice[index].high.toString()}',style: TextStyle(fontSize: 15,color: Colors.green,fontWeight: FontWeight.w600))
                                              ],
                                            ),
                                            Divider(),
                                            Text('Model कीमत',style: TextStyle(fontSize: h*0.017,color: kGreyColor,fontWeight: FontWeight.w600)),
                                            Text('₹${mandiprice[index].model.toString()}',style: TextStyle(fontSize: h*0.02,color: ksubprime,fontWeight: FontWeight.w600))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ) ;
                            }),
                        Container(
                          margin: EdgeInsets.all(5),
                          height:bannerAd.size.height.toDouble(),
                          width: bannerAd.size.width.toDouble(),
                          child: adWidget,
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('mandiprice').snapshots(), builder: (BuildContext context,
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
                                          // image: DecorationImage(
                                          //     image: NetworkImage(bannners['banner'],),fit: BoxFit.fill
                                          // )
                                      ),
                                      child: PhotoView(

                                        imageProvider: NetworkImage(bannners['banner']),
                                      )

                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  scrollPhysics:  snapshot.data!.docs.length == 1 ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics(),
                                  height: h*0.6,
                                  viewportFraction: 1,
                                  autoPlayAnimationDuration: Duration(seconds: 2),
                                  autoPlayInterval: Duration(seconds: 15),
                                  autoPlay: snapshot.data!.docs.length == 1 ? false : true,
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
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> getmandiprice()async{
    CollectionReference  inst = FirebaseFirestore.instance.collection('madhibhav');
    DocumentSnapshot snapshot = await inst.doc('priceof').get();
    mandiprice.clear();
    var lastdata = snapshot['price'] as List<dynamic>;
    lastdata.forEach((element) {
      mandiprice.add(MandiBhav.fromJson(element));
    });
    if(mounted){
      setState(() {
      });
    }
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
}
