

 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'cat_products_view.dart';

class CatView extends StatelessWidget {
  const CatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0.4,
        backgroundColor:ColorsManager.primary2,
        automaticallyImplyLeading: false,
        title: const Custom_Text(text: ' الاقسام ',fontSize: 26,alignment: Alignment.center,
            color:ColorsManager.primary3),
      ),
      body:
      ListView(
        children: [
          const SizedBox(height: 20,),
          CatWidget(),
        ],
      )

    );
  }
}
 Widget CatWidget() {

   return
     SizedBox(
       height: 2000,
       child: StreamBuilder(
           stream: FirebaseFirestore.instance
               .collection('categories').snapshots(),
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
                         childAspectRatio: 1.3),
                     //physics: const NeverScrollableScrollPhysics(),
                     itemCount: snapshot.data!.docs.length,
                     itemBuilder: (context, index) {
                       DocumentSnapshot posts = snapshot.data!.docs[index];
                       if (snapshot.data == null) {
                         return const CircularProgressIndicator();
                       }
                       return InkWell(
                         child: Padding(
                           padding: const EdgeInsets.all(4.0),
                           child: Container(
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: ColorsManager.primary3),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget>[

                                 Center(
                                   child: Custom_Text(
                                     text: posts['name'],
                                     fontSize: 30,
                                     color:ColorsManager.white,
                                     alignment: Alignment.center,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),


                               ],
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