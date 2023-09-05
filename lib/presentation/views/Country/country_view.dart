
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:flutter/material.dart';
import 'package:shop_app/presentation/resources/assets_manager.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';

import 'package:get_storage/get_storage.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import '../Home/main_home.dart';

class CountryView extends StatelessWidget {
  
  const CountryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primary2,
      appBar:AppBar(
        backgroundColor:ColorsManager.primary3,
        toolbarHeight: 60,
        title:const Custom_Text(text: 'Mnsa Store',
        fontSize: 27,alignment:Alignment.center,
          color:ColorsManager.primary2,
        ),
      ),
      body: CountriesWidget()
      
      
      // ListView(
      //   children: [
      //     const SizedBox(height: 20,),
      //     SizedBox(
      //       height: 180,
      //       child:Image.asset(AssetsManager.Logo),
      //     ),
      //     const SizedBox(height: 2,),
      //     CountriesWidget()
      //   ],
      // )
    );
  }
}


Widget CountriesWidget(){



  return StreamBuilder(
      stream:
      FirebaseFirestore.instance.collection('countries')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return  const Center(child: CircularProgressIndicator());
          default:
            return ListView.builder(
             // physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot posts = snapshot.data!.docs[index];
                  if(snapshot.data == null) return const CircularProgressIndicator();
                  return
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: ListTile(
                                leading: SizedBox(
                                  width: 60,
                                    child: Image.network(posts['img'])),
                                title: Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Text(posts['name']??" ",
                                      style:const TextStyle(color:Colors.black,fontSize:24,fontWeight:FontWeight.w300)),
                                ),
                                onTap:(){


                                  final box=GetStorage();

                                  box.remove('country');
                                  box.remove('currency');

                                  box.write('country', posts['name']);
                                  box.write('currency', posts['currency']);
                                  print(posts['name']);
                                  Get.to(const MainHome());
                                  },
                              ),
                            ),
                            const SizedBox(height: 5,)


                          ],
                        ),

                      ),
                    );
                });
        }
      }
  );
}