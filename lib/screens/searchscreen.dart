import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shridungargarh/utils/constent.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home-screen/mobilenumber.dart';
class SearchScreen extends StatefulWidget {
   SearchScreen({Key? key}) : super(key: key);
   static String searchwork = '';


  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  ScrollController _controller = ScrollController();
  var size,w,h;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(left: w*0.01,right: w*0.01),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: h*0.02,),
                 Container(
                   width: w*1,
                   color: kWhiteColor,
                   child: TextField(
                     onChanged: (query){
                       setState(() {
                         SearchScreen.searchwork = query;
                       });
                     },
                    decoration: InputDecoration(
                      prefixIcon: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
                        Navigator.pop(context);
                      }),
                      contentPadding: EdgeInsets.all(h*0.01),
                      label: Text('search'),
                      hintText: 'हिंदी में खोजें , मोबाइल नंबर',
                      hintStyle: TextStyle(color: kBlackColor),
                      labelStyle: TextStyle(color: kBlackColor),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kGreyColor),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: kGreyColor),
                      ),
                    ),
                ),
                 ),
                SizedBox(height: h*0.01,),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('mobilenumber').where('cate',isGreaterThanOrEqualTo:SearchScreen.searchwork).snapshots(), builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return  GridView.builder(
                          controller: _controller,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length >= 10 ? 8 : snapshot.data!.docs.length,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
