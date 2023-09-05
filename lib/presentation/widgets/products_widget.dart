//
//
//
//  import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:shop_app/presentation/views/products/product_details_view.dart';
// import 'package:shop_app/presentation/widgets/Custom_Text.dart';
//
// import '../resources/color_manager.dart';
//
// class AllProductsWidget extends StatefulWidget {
//   const AllProductsWidget({Key? key}) : super(key: key);
//
//   @override
//   State<AllProductsWidget> createState() => _AllProductsWidgetState();
// }
//
//
// class _AllProductsWidgetState extends State<AllProductsWidget> {
//
//
//
//   bool _streamFinished = false;
//   double _sizedBoxHeight = 123660.0;
//
//   @override
//   Widget build(BuildContext context) {
//     final box=GetStorage();
//     String country=box.read('country');
//     String currency=box.read('currency');
//
//     return SizedBox(
//       height: _sizedBoxHeight,
//       child: StreamBuilder(
//           stream: FirebaseFirestore.instance.collection('products').where(
//               'country', isEqualTo: country).snapshots(),
//           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             switch (snapshot.connectionState) {
//               case ConnectionState.waiting:
//                 return const Center(child: CircularProgressIndicator());
//               default:
//                 if (snapshot.connectionState == ConnectionState.done && !_streamFinished) {
//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     setState(() {
//                       _streamFinished = true;
//                       _sizedBoxHeight = MediaQuery.of(context).size.height;
//                     });
//                   });
//                 }
//                 return GridView.builder(
//                    // controller: _scrollController,
//                    physics: const NeverScrollableScrollPhysics(),
//
//                        // : const  NeverScrollableScrollPhysics(),
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 2,
//                         mainAxisSpacing: 4,
//                         childAspectRatio: 0.85
//                     ),
//                   //  physics: const NeverScrollableScrollPhysics(),
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (context, index) {
//                       DocumentSnapshot posts = snapshot.data!.docs[index];
//                       if (snapshot.data == null) {
//                         return const CircularProgressIndicator();
//                       }
//                       return InkWell(
//                         child: Hero(
//                           tag: 'img$index',
//                           child: Padding(
//                             padding: const EdgeInsets.all(4.0),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: ColorsManager.primary2
//                               ),
//                               child: Column(
//                                 children: <Widget>[
//                                   SizedBox(
//                                     height: 130,
//                                     width: MediaQuery
//                                         .of(context)
//                                         .size
//                                         .width,
//                                     child: Image.network(posts['image'][0],
//                                       fit: BoxFit.fitWidth,),),
//                                   const SizedBox(
//                                     height: 2,
//                                   ),
//                                   Custom_Text(text: posts['cat'],
//                                     fontSize: 14,
//                                     alignment: Alignment.center,
//                                     color: Colors.grey,
//                                   ),
//                                   const SizedBox(height: 2,),
//                                   Custom_Text(text: posts['name'],
//                                     fontSize: 16,
//                                     alignment: Alignment.center,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   const SizedBox(height: 3,),
//                                   RatingBar.builder(
//                                     itemSize: 14,
//                                     initialRating: double.parse(
//                                         posts['rate'].toString()),
//                                     minRating: 1,
//                                     direction: Axis.horizontal,
//                                     allowHalfRating: true,
//                                     itemCount: 5,
//                                     itemPadding:
//                                     const EdgeInsets.symmetric(
//                                         horizontal: 1.0),
//                                     itemBuilder: (context, _) =>
//                                     const Icon(
//                                       Icons.star,
//                                       color: Colors.amber,
//                                     ),
//                                     unratedColor: Colors.grey,
//                                     onRatingUpdate: (rating) {
//                                       print(rating);
//                                     },
//                                   ),
//                                   const SizedBox(height: 3,),
//                                   Custom_Text(
//                                     text: "${posts['price']} " "  $currency",
//                                     fontSize: 16,
//                                     alignment: Alignment.center,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         onTap: () {
//                           Get.to(ProductDetailsView(
//                               posts: posts,
//                               tag: 'img$index'
//                           ));
//                         },
//                       );
//                     });
//
//
//             }
//           }),
//     );
//   }
// }
