

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/presentation/resources/assets_manager.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Cat/cat_products_view.dart';
import 'main_home.dart';

 class AppStartView extends StatefulWidget {
  AppStartView({Key? key}) : super(key: key);

  @override
  State<AppStartView> createState() => _AppStartViewState();
}

class _AppStartViewState extends State<AppStartView> {
  bool loadx=false;

  @override
  void initState() {
    Future.delayed(const
    Duration(seconds: 1)).then((value) {
      setState(() {
        loadx=true;
      });

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.ColorHelper3,
      // appBar:AppBar(
      //   backgroundColor:ColorsManager.primary,
      //   toolbarHeight: 4,
      // ),
      body:

      SingleChildScrollView(
        child: Stack(
          children: [

            SizedBox(
              height: MediaQuery.of(context).size.height,
              child:Image.asset('assets/images/op.png',

              )),
            SizedBox(
                height: MediaQuery.of(context).size.height,
                child:Image.asset('assets/images/op.png',
                //  fit:BoxFit.fill,
                )),
            CatWidget(),

          ],
        ),
      ),
    );
  }
}
Widget CatWidget() {

  final box=GetStorage();
  String keylocal=box.read('locale')??'';
  String cat='name';
  if(keylocal=='en'){
    cat='name';
  }else if(keylocal=='ar'){
    cat='nameAr';
  }


  return
    StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('categories')
            .orderBy('num', descending: false)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              return Column(
                children: [
                  const SizedBox(height: 80,),
                  SizedBox(
                    height: 4444,
                    child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 3,
                            mainAxisSpacing: 4,
                            childAspectRatio: 2.6),
                        //physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot posts = snapshot.data!.docs[index];
                          if (snapshot.data == null) {
                            return const CircularProgressIndicator();
                          }
                          return Container(
                            height: 36,
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              child:Container(
                                decoration:BoxDecoration(
                                  borderRadius:BorderRadius.circular(34),
                                      color:Colors.transparent,
                                  border:Border.all(color:ColorsManager.primary)
                                ),
                                child:Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Custom_Text(text:posts[cat]
                                    ,fontSize: 18,
                                  alignment:Alignment.center

                                    ,color:ColorsManager.ColorHelper,
                                    fontWeight:FontWeight.bold,
                                  ),
                                ),
                              ),

                              onTap: () {

                                if(posts['nameAr']=='نسق مع أوفيليا'){

                                  openWhatsApp("+966537755534",'');

                                }else{

                                  Get.to(CatProductsView(
                                    cat: posts['name'],
                                  ));


                                }

                               // Get.to(const  MainHome());
                              },
                            ),
                          );
                        }),
                  ),
                ],
              );
          }
        });
}
void openWhatsApp(String phoneNumber, String message) async {
  // The 'whatsapp://' scheme is used to open WhatsApp
  // Replace the country code prefix '+' with '00' for international numbers
  String url =
   "whatsapp://send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}";

    //  'tel:+$phoneNumber';
  if (await canLaunch(url)) {

    await launch(url);
  } else {
    await launch(url);
    throw "Could not launch WhatsApp.";
  }
}