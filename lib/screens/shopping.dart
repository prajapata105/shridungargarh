// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:shridungargarh/utils/constent.dart';
//
// import '../dftbutton.dart';
// class Shopping extends StatefulWidget {
//   const Shopping({Key? key}) : super(key: key);
//
//   @override
//   State<Shopping> createState() => _ShoppingState();
// }
//
// class _ShoppingState extends State<Shopping> {
//   final ScrollController _scrollController = ScrollController();
//   var size,w,h;
//   @override
//   Widget build(BuildContext context) {
//     size = MediaQuery.of(context).size;
//     h = size.height;
//     w = size.width;
//     return Scaffold(
//       backgroundColor: kBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: kBackgroundColor,
//         elevation: 0,
//         title: const Text(
//           'Shopping',
//           style: TextStyle(color: ksubprime, fontWeight: FontWeight.bold),
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             child: Icon(
//               Icons.search,
//               color: ksubprime,
//             ),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             CarouselSlider(
//               items: [
//                 Container(
//                   margin: const EdgeInsets.all(2),
//                   width: w * 0.9,
//                   decoration: BoxDecoration(
//                       color: kWhiteColor,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                             color: kWhiteColor.withOpacity(0.20),
//                             spreadRadius: 2,
//                             blurRadius: 4),
//                       ],
//                       image: const DecorationImage(
//                           image: AssetImage('assets/imagesvg/offers.jpg'),
//                           fit: BoxFit.fill)),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.all(5),
//                   width: w * 0.8,
//                   decoration: BoxDecoration(
//                       color: kWhiteColor,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                             color: kWhiteColor.withOpacity(0.20),
//                             spreadRadius: 2,
//                             blurRadius: 4),
//                       ],
//                       image: const DecorationImage(
//                           image: AssetImage('assets/imagesvg/offers2.jp'),
//                           fit: BoxFit.fill)),
//                 )
//               ],
//               options: CarouselOptions(
//                 height: h * 0.14,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: w * 0.04),
//               child: const Divider(
//                 color: kBlackColor,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: w * 0.04),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'whats your type?',
//                     style: TextStyle(
//                         color: ksubprime,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 15),
//                   ),
//                   const Text(
//                     'Categories',
//                     style: TextStyle(
//                         color: Colors.green, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: h * 0.02,
//             ),
//             GridView.builder(
//                 itemCount: 10,
//                 shrinkWrap: true,
//                 controller: _scrollController,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: h * 0.01,
//                   childAspectRatio: 0.9
//                 ),
//                 itemBuilder: (BuildContext context, int index) {
//                   return Stack(
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           option();
//                         },
//                         child: Container(
//                           height: h * 0.26 ,
//                           width: w * 0.42,
//                           margin: EdgeInsets.only(
//                             left: w * 0.04,
//                           ),
//                           decoration: BoxDecoration(
//                               color: Colors.black12,
//                               borderRadius: BorderRadius.circular(20),
//                               image: DecorationImage(
//                                   image: const AssetImage(
//                                     'assets/imagesvg/jaipur.jpg',
//                                   ),
//                                   fit: BoxFit.fill)),
//                         ),
//                       ),
//                       Positioned(
//                           top: h * 0.21,
//                           left: w * 0.25,
//                           child: Container(
//                             height: h * 0.03,
//                             padding: EdgeInsets.symmetric(horizontal: w * 0.02),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(25),
//                               color: kBlackColor.withOpacity(0.70),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: const [
//                                 Text(
//                                   'Price ',
//                                   style:
//                                       TextStyle(color: kWhiteColor, fontSize: 15),
//                                 ),
//                                 Text(
//                                   '399',
//                                   style:
//                                       TextStyle(color: kWhiteColor, fontSize: 14),
//                                 ),
//                               ],
//                             ),
//                           )),
//                     ],
//                   );
//                 })
//           ],
//         ),
//       ),
//     );
//   }
//
//   option() {
//     showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 topRight: const Radius.circular(30), topLeft: Radius.circular(30))),
//         builder: (context) {
//           return Container(
//             height: h * 0.86,
//             padding:
//                 EdgeInsets.symmetric(vertical: h * 0.02, horizontal: w * 0.06),
//             child: Column(
//               children: <Widget>[
//                 CarouselSlider(
//                   items: [
//                     Container(
//                       margin: EdgeInsets.all(2),
//                       width: w * 2,
//                       decoration: BoxDecoration(
//                           color: kWhiteColor,
//                           borderRadius: BorderRadius.circular(16),
//                           boxShadow: [
//                             BoxShadow(
//                                 color: kWhiteColor.withOpacity(0.20),
//                                 spreadRadius: 2,
//                                 blurRadius: 4),
//                           ],
//                           image: DecorationImage(
//                               image: AssetImage('assets/imagesvg/offers.jpg'),
//                               fit: BoxFit.fill)),
//                     ),
//                     Container(
//                       margin: EdgeInsets.all(5),
//                       width: w * 2,
//                       decoration: BoxDecoration(
//                           color: kWhiteColor,
//                           borderRadius: BorderRadius.circular(16),
//                           boxShadow: [
//                             BoxShadow(
//                                 color: kWhiteColor.withOpacity(0.20),
//                                 spreadRadius: 2,
//                                 blurRadius: 4),
//                           ],
//                           image: DecorationImage(
//                               image: AssetImage('assets/imagesvg/offers2.jp'),
//                               fit: BoxFit.fill)),
//                     )
//                   ],
//                   options: CarouselOptions(
//                     height: h * 0.30,
//                   ),
//                 ),
//                 SizedBox(
//                   height: h * 0.03,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Flexible(
//                         child: Text(
//                       'Maxlife Of India',
//                       maxLines: 4,
//                       overflow: TextOverflow.fade,
//                       style: TextStyle(
//                           color: ksubprime,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600),
//                     )),
//                   ],
//                 ),
//                 SizedBox(
//                   height: h * 0.03,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Color(0xfff6fff8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color(0xff45905a),
//                           blurRadius: 2,
//                           spreadRadius: 2,
//                         )
//                       ]),
//                   child: ListTile(
//                     title: Text(
//                       'Price 999',
//                       style: TextStyle(
//                           color: ksubprime,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     trailing
//           :ElevatedButton(
//                         // splashColor: Colors.yellowAccent,
//                       style:ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                             side: BorderSide(
//                                 color: Colors.white,
//                                 width: 1,
//                                 style: BorderStyle.solid),
//                             borderRadius: BorderRadius.circular(50)),
//                         backgroundColor: ksubprime,
//                       ),
//                         onPressed: () {},
//                         child: Text(
//                           "Call",
//                           style: TextStyle(color: kWhiteColor, fontSize: 16),
//                         )),
//                   ),
//                 ),
//                 SizedBox(
//                   height: h * 0.03,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       'Description',
//                       style: TextStyle(
//                           color: ksubprime,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 20),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Flexible(
//                       child: Text(
//                         'Now, at the click of a button,'
//                         ' we will show the bottom sheet in which'
//                         ' the column has been taken inside the'
//                         ' bottom sheet and used the List Tile'
//                         ' widget inside the column widget, in which '
//                         'some images and titles are displayed',
//                         overflow: TextOverflow.fade,
//                         maxLines: 7,
//                         style: TextStyle(
//                           color: kBlackColor.withOpacity(0.90),
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Divider(color: kBlackColor,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text("Product Code:"),
//                     const Text("3232"),
//                   ],
//                 ),
//                 const Divider(color: kBlackColor,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     SizedBox(
//                       height: h*0.06,
//                       width: w*0.39,
//                       child: OutlinedButton(
//                         style: OutlinedButton.styleFrom(
//                           foregroundColor: kWhiteColor, side: const BorderSide(color: ksubprime, width: 1),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         child: Text("Close", style: TextStyle( fontSize: h*0.019,color: ksubprime),),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ),
//                     DftButton(
//                       color: ksubprime,
//                       width: w * 0.15,
//                       height: h * 0.019,
//                       text: "Share",
//                       press: () {},
//                       textcolor: kBlackColor,
//                       radius: h*0.03,
//                     ),
//
//                   ],
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }
