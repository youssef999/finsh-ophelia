
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/presentation/widgets/drawer.dart';
import '../../const/app_message.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/Custom_Text.dart';
import '../Cat/cat_products_view.dart';
import '../Search/search_view.dart';
import '../products/product_details_view.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

 class _HomeViewState extends State<HomeView> {

   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorsManager.ColorHelper,
        drawer: const MainDrawer(),
        body: ListView(
          children: [
            AppBarWidget(context),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ProductWidget(),
            ),
          ],
        )
    );
  }


   Widget AppBarWidget(BuildContext context){

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
             _scaffoldKey.currentState?.openDrawer();


           }, icon: const Icon(Icons.drag_handle,size: 39,color:ColorsManager.primary,)),
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

 RectTween createRectTween(Rect begin, Rect end) {
return CustomRectTween(begin: begin, end: end);
}
class CustomRectTween extends RectTween {
  CustomRectTween({required Rect begin, required Rect end})
      : super(begin: begin, end: end) {}


}
Widget ProductWidget() {

  return
    SizedBox(
      height: 222232,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('products')
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
                                      padding:
                                   EdgeInsets.only(top: MediaQuery.of(context).size.height*0.27),
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

Widget CatWidget() {
  return SizedBox(
    height: 140,
    child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot posts = snapshot.data!.docs[index];
                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }
                    return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorsManager.primary2),
                          //  color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 100,
                              //height: 2,
                              child: Custom_Text(
                                text: posts['name'],
                                fontSize: 16,
                                alignment: Alignment.center,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.to(CatProductsView(
                          cat: posts['name'],
                        ));
                      },
                    );
                  });
          }
        }),
  );
}


