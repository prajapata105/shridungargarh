import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/constent.dart';
class Newsupdate extends StatefulWidget {
  const Newsupdate({Key? key}) : super(key: key);

  @override
  State<Newsupdate> createState() => _NewsupdateState();
}

class _NewsupdateState extends State<Newsupdate> {
  var size,w,h;
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController _news = TextEditingController();
  TextEditingController _tital = TextEditingController();
  TextEditingController _image = TextEditingController();
  TextEditingController _htital = TextEditingController();
  TextEditingController _time = TextEditingController();
  CollectionReference idpassword = FirebaseFirestore.instance.collection('news');
  var titaln = '';
  var newsi = '';
  var htitaln = '';
  var imagen = '';
  var times = DateTime.now();

  Future<void> Addnews()async{
    idpassword.add({'tital': titaln,'htital':htitaln,'news': newsi,'time': times,'image':imagen});
  }



  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;


    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: h*0.02,),
              Text('${imagen}'),
              TextFormField(    onChanged: (value){
                setState(() {
                  titaln = value;
                });
              },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(h*0.01),
                  label: Text('tital'),
                  hintText: 'tital',
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
              SizedBox(height: h*0.02,),
              TextFormField(
                onChanged: (value){
                  setState(() {
                    htitaln = value;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(h*0.01),
                  label: Text('htital'),
                  hintText: 'htital',
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
              SizedBox(height: h*0.02,),
              TextFormField(
                onChanged: (value){
                  setState(() {
                  imagen = value;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(h*0.01),
                  label: Text('image'),
                  hintText: 'image',
                  hintStyle: TextStyle(color: kBlackColor),
                  labelStyle: TextStyle(color: kBlackColor),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kGreyColor),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: kGreyColor)
                  ),
                ),
              ),
              SizedBox(height: h*0.02,),
              TextFormField(
                onChanged: (value){
                  setState(() {
                    newsi = value;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(h*0.01),
                  label: Text('news'),
                  hintText: 'news',
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
              SizedBox(height: h*0.02,),
              ElevatedButton(onPressed: (){
                setState((){
                  Addnews();
                  Get.snackbar(
                      "",
                      "",
                      colorText: kWhiteColor,
                      backgroundColor: kPrimaryColor,
                      snackPosition: SnackPosition.TOP,
                      titleText: Text('आपकी जानकारी 24 घंटे के अंदर जोड़ दी जाएगी',style: TextStyle(color: kWhiteColor,fontSize: 17),textAlign: TextAlign.center,)
                  );
                });
              }, child: Text('add'))

            ],
          ),
        ),
      ),
    );
  }
}
