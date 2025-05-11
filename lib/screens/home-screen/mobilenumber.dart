import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shridungargarh/utils/constent.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import '../../model/mobiledetails.dart';
import 'package:url_launcher/url_launcher.dart';

class MobileNumbers extends StatefulWidget {
  String? id, cate;

   MobileNumbers({super.key, this.id, this.cate});

  @override
  State<MobileNumbers> createState() => _MobileNumbersState();
}

class _MobileNumbersState extends State<MobileNumbers> {
  final ScrollController _controller = ScrollController();
  List<Mobiledetails> mobilenumberdatas = [];
  List<Banners> bannerslist = [];
  late BannerAd bannerAd;
  final String adunitId = "ca-app-pub-9490799633031429/8803157862";
  var size, w, h;
  var mobile = "";
  var bname = "";
  var oname = "";
  final mobilecontroller = TextEditingController();
  final onamecontroller = TextEditingController();
  final bnamecontroller = TextEditingController();

  CollectionReference idpassword = FirebaseFirestore.instance.collection('newrequst');

  Future<void> Addid()async{
     idpassword.add({'mobile': mobile,'bname':bname,'oname': oname});
  }

  @override
  void initState() {
    getmobilenumber();
    getbanners();
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: adunitId,
        listener: bannerAdListener,
        request: const AdRequest());
    bannerAd.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(ad: bannerAd);
    size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    return SafeArea(
        child: Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: h * 0.07,
        width: w * 0.4,
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  contentPadding: EdgeInsets.all(20),
                  actionsAlignment: MainAxisAlignment.spaceAround,
                  title: Text('अपने व्यापार का विवरण जोड़ें',textAlign: TextAlign.center),
                  actions: [
                    TextField(
                      controller:  bnamecontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'व्यापार का नाम',
                        hintText: 'व्यापार का नाम',
                      ),
                    ),
                    SizedBox(height: h*0.02,),
                    TextField(
                      controller:  onamecontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'मालिक का नाम',
                        hintText: 'मालिक का नाम',
                      ),
                    ),
                    SizedBox(height: h*0.02,),
                    TextField(
                      controller: mobilecontroller,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'मोबाइल नंबर',
                        hintText: 'मोबाइल नंबर',
                      ),
                    ),
                    SizedBox(height: h*0.02,),
                    ElevatedButton(
                      onPressed: (){
                        setState((){
                          mobile = mobilecontroller.text;
                          oname = onamecontroller.text;
                          bname = bnamecontroller.text;
                          Addid();
                          Get.back();
                          Get.snackbar(
                            "",
                            "",
                             colorText: kWhiteColor,
                             backgroundColor: kPrimaryColor,
                            snackPosition: SnackPosition.TOP,
                            titleText: Text('आपकी जानकारी 24 घंटे के अंदर जोड़ दी जाएगी',style: TextStyle(color: kWhiteColor,fontSize: 17),textAlign: TextAlign.center,)
                          );
                        });
                        },
                      //return true when click on "Yes"
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        side: BorderSide(color: kPrimaryColor),
                        minimumSize: Size(w*0.8, h*0.047),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                      ),
                      child:Text('save',style: TextStyle(fontSize: 18,color: kWhiteColor),),
                    ),
                  ],
                );
              },
            );
          },
          backgroundColor: kWhiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: const Text(
            'अपना मोबाइल नंबर जोड़ें',
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kWhiteColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kTitleColor,
            )),
        title: Text(
          widget.cate.toString(),
          style: const TextStyle(
              color: ksubprime, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider.builder(
              options: bannerslist.isNotEmpty
                  ? CarouselOptions(height: h * 0.18)
                  : CarouselOptions(height: h * 0),
              itemCount: bannerslist.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                return bannerslist.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.all(5),
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
                                image: NetworkImage(
                                    bannerslist[itemIndex].banners.toString()),
                                fit: BoxFit.fill)),
                      )
                    : Container();
              },
            ),
            SizedBox(
              height: h * 0.01,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(5),
              width: w * 0.92,
              height: h * 0.07,
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
              child: adWidget,
            ),
            SizedBox(
              height: h * 0.01,
            ),
            ListView.builder(
                controller: _controller,
                itemCount: mobilenumberdatas.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return mobilenumberdatas.isEmpty
                      ? const CircularProgressIndicator()
                      : Container(
                          padding: EdgeInsets.all(h * 0.01),
                          margin: EdgeInsets.only(
                              left: w * 0.02,
                              right: w * 0.02,
                              bottom: h * 0.02),
                          width: w * 01,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: kWhiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: kPrimaryColor.withOpacity(0.1),
                                  blurRadius: 7,
                                  spreadRadius: 5,
                                  offset: const Offset(1, 1),
                                )
                              ]),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: h * 0.09,
                                width: w * 0.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    gradient: index.isEven
                                        ? const LinearGradient(
                                            colors: [
                                              Color(0xff0CAFFF),
                                              Color(0xff99FFFF),
                                            ],
                                          )
                                        : const LinearGradient(
                                            colors: [
                                              Color(0xffE6E6FA),
                                              Color(0xffEE82EE),
                                            ],
                                          ),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            mobilenumberdatas[index]
                                                .bimage
                                                .toString()),
                                        fit: BoxFit.fill)),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: h * 0.010, top: h * 0.002),
                                    width: w * 0.6,
                                    child: Text(
                                      mobilenumberdatas[index].bname.toString(),
                                      style: TextStyle(
                                          color: ksubprime,
                                          fontWeight: FontWeight.bold,
                                          fontSize: h * 0.025),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                        left: w * 0.02, right: w * 0.02),
                                    margin: EdgeInsets.only(
                                        left: h * 0.010, top: h * 0.002),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: kBlackColor.withOpacity(0.20)),
                                    child: Text(mobilenumberdatas[index]
                                        .oname
                                        .toString()),
                                  ),
                                  Container(
                                    width: w * 0.7,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: h * 0.03,
                                          margin: EdgeInsets.only(
                                              left: h * 0.010,
                                              top: h * 0.003,
                                              right: h * 0.010),
                                          child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor: kBlackColor,
                                              side: const BorderSide(
                                                  color: kPrimaryColor,
                                                  width: 1),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            child: const Text('Call'),
                                            onPressed: () async {
                                              FlutterPhoneDirectCaller
                                                  .callNumber(
                                                      mobilenumberdatas[index]
                                                          .mobile
                                                          .toString());
                                            },
                                          ),
                                        ),
                                        InkWell(
                                          hoverColor: kGreyColor,
                                          focusColor: kWhiteColor,
                                          splashColor: kWhiteColor,
                                          highlightColor: kGreyColor,
                                          onTap: () async {
                                            var whatsappUrl =
                                                "whatsapp://send?phone=91${mobilenumberdatas[index].mobile}";
                                            await canLaunch(whatsappUrl) != null
                                                ? launch(whatsappUrl)
                                                : print(
                                                    "open WhatsApp app link or do a snackbar with notification that there is no WhatsApp installed");
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: h * 0.03,
                                            width: w * 0.2,
                                            margin: EdgeInsets.only(
                                                left: h * 0.010,
                                                top: h * 0.003,
                                                right: h * 0.010),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: kPrimaryColor,
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: kwhatsapp,
                                                      blurRadius: 8,
                                                      offset: Offset(0, 1))
                                                ]),
                                            child: const Text(
                                              'WhatsApp',
                                              style:
                                                  TextStyle(color: kWhiteColor),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                }),
            SizedBox(
              height: h * 0.09,
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> getmobilenumber() async {
    CollectionReference inst =
        FirebaseFirestore.instance.collection('mobilenumber');
    DocumentSnapshot snapshot = await inst.doc(widget.id).get();
    mobilenumberdatas.clear();
    var lastdata = snapshot['catemap'] as List<dynamic>;
    lastdata.forEach((element) {
      mobilenumberdatas.add(Mobiledetails.fromJson(element));
    });
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getbanners() async {
    CollectionReference inst = FirebaseFirestore.instance.collection('mobilenumber');
    DocumentSnapshot snapshot = await inst.doc(widget.id).get();
    bannerslist.clear();
    var lastdata = snapshot['bannerimage'] as List<dynamic>;
    lastdata.forEach((element) {
      bannerslist.add(Banners.fromJson(element));
    });
    if (mounted) {
      setState(() {});
    }
  }

  final BannerAdListener bannerAdListener = BannerAdListener(onAdLoaded: (Ad ad) {
    print('load');
  }, onAdFailedToLoad: (Ad ad, LoadAdError error) {
    ad.dispose();
    print('Ad fiald to load $error');
  }, onAdOpened: (Ad ad) {
    print('open add');
  });
}
