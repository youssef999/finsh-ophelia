import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/presentation/const/app_message.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/resources/strings_manager.dart';
import 'package:shop_app/presentation/views/products/product_details_view.dart';
import '../../widgets/Custom_Text.dart';
import 'package:get/get.dart';

class CatProductsView extends StatelessWidget {
  String cat;

  CatProductsView({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:ColorsManager.ColorHelper,
      body:  ListView(
        children: [
          AppBarWidget(),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: CatProductWidget(),
          ),
        ],
      )
    );
  }

  Widget CatProductWidget() {

    return
      SizedBox(
        height: 22222,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('products').where('cat',isEqualTo: cat)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 4,
                          childAspectRatio: 0.62),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot posts = snapshot.data!.docs[index];
                        if (snapshot.data == null) {
                          return const CircularProgressIndicator();
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Hero(
                              createRectTween: (begin, end) {
                                return MaterialRectCenterArcTween(begin: begin, end: end);
                              },
                              placeholderBuilder: (
                                  BuildContext context,
                                  Size heroSize,
                                  Widget child,
                                  ) {
                                return Center(
                                  child: LoadingAnimationWidget.fourRotatingDots(
                                    color: ColorsManager.ColorHelper2,
                                    size: 55,
                                  ),
                                );
                              },

                              tag: 'img$index',
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorsManager.primary2),
                                  child: Stack(
                                    // physics: const NeverScrollableScrollPhysics(),
                                    children: <Widget>[
                                      SizedBox(
                                        height:MediaQuery.of(context).size.height*0.6,
                                        width: MediaQuery.of(context).size.width,
                                        child: Image.network(
                                          posts['image'],
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),

                                      Padding(
                                        padding:EdgeInsets.only(top: MediaQuery.of(context).size.height*0.27),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 65,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    Colors.grey[300]!,
                                                    Colors.white60,
                                                    //   Colors.transparent,
                                                    Colors.white60,
                                                    Colors.white60
                                                  ]
                                              ),

                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(3.0),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(left:8.0,right:3),
                                                            child: Wrap(
                                                              children: [
                                                                SizedBox(
                                                                  // width:120,
                                                                  child: Custom_Text(
                                                                    text: posts['name'],
                                                                    fontSize: 17,
                                                                    textAlign:TextAlign.center,
                                                                    alignment:Alignment.topRight,
                                                                    color: ColorsManager.black,
                                                                    fontWeight:FontWeight.w800,
                                                                    //  alignment: Alignment.topLeft,
                                                                  ),
                                                                ),
                                                              ],

                                                            ),
                                                          ),
                                                          const SizedBox(height: 10,),


                                                          Custom_Text(
                                                            text:
                                                            posts['price'].toString()+" "+"currency".tr,
                                                            fontSize: 13,
                                                            color: ColorsManager.black,
                                                            fontWeight: FontWeight.w700,
                                                            alignment: Alignment.center,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // SizedBox(width: 3,),


                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Positioned(
                                      //   bottom: 5,
                                      //   child: Container(
                                      //     width: MediaQuery.of(context).size.width,
                                      //     decoration: BoxDecoration(
                                      //       color: ColorsManager.white,
                                      //       borderRadius: BorderRadius.circular(13)
                                      //     ),
                                      //     child: Column(
                                      //       mainAxisAlignment: MainAxisAlignment.center,
                                      //       crossAxisAlignment: CrossAxisAlignment.center,
                                      //       children: [
                                      //
                                      //         SizedBox(
                                      //           width:120,
                                      //           child: Wrap(
                                      //               children:[
                                      //                 Center(
                                      //                   child: Text(
                                      //                       posts['name'],
                                      //                       maxLines:2,
                                      //                       style: GoogleFonts.tajawal(
                                      //                         color:ColorsManager.black,fontSize: 22,fontWeight: FontWeight.bold,
                                      //                         textBaseline: TextBaseline.alphabetic,
                                      //                       )
                                      //                   ),
                                      //                 ),
                                      //               ]
                                      //           ),
                                      //         ),
                                      //         const SizedBox(
                                      //           height: 5,
                                      //         ),
                                      //         Custom_Text(
                                      //           text: "${posts['price']}" +"  "+currency ,
                                      //           fontSize: 19,
                                      //           alignment: Alignment.center,
                                      //           fontWeight: FontWeight.w500,
                                      //           color:ColorsManager.ColorHelper,
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),


                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              Get.to(
                                  ProductDetailsView(posts: posts, tag: 'img$index'));
                            },
                          ),
                        );
                      });
              }
            }),
      );
  }

  Widget AppBarWidget(){

    return Container(
      height: 75,
      decoration: const BoxDecoration(
          borderRadius:BorderRadius.all(Radius.circular(13)),
          color:ColorsManager.ColorHelper
      ),
      child:Row(
        children: [
          const SizedBox(width: 30,),
          IconButton(onPressed: (){
            Get.back();
          }, icon: const Icon(Icons.arrow_back_ios,size: 39,color:ColorsManager.primary,)),
          const SizedBox(width: 70,),
          const Padding(
            padding: EdgeInsets.only(top:18.0),
            child: Custom_Text(text: StringManger.AppName,fontSize: 31,alignment:Alignment.center,color:ColorsManager.primary,),
          )
        ],
      ),
    );
  }
}