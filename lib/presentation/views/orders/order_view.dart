import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import '../../const/app_message.dart';



 class OrdersView extends StatelessWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          backgroundColor: ColorsManager.ColorHelper,
          title:  Custom_Text(
            text: 'myOrders'.tr,
            fontSize: 20,
            alignment: Alignment.center,
            color: ColorsManager.primary2,
          ),
          leading: InkWell(
            child:
            const Icon(Icons.arrow_back_ios, size: 27, color: Colors.white),
            onTap: () {
              Get.back();
            },
          )),
      body: ListView(
        children: [
          const SizedBox(
            height: 12,
          ),
          UserOrdersWidget()
        ],
      ),
    );

  }

}

Widget UserOrdersWidget() {


  final box = GetStorage();
  String phone= box.read('phone') ?? "x";


  return Container(
    height: 76600,
    color: ColorsManager.primary2,
    child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('phone', isEqualTo: phone)
            //.orderBy('date', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot posts = snapshot.data!.docs[index];
                    String status = '';
                    if (posts['status'] == 'refused') {
                      status = 'refuse'.tr;
                    } else if (posts['status'] == 'accept') {
                      status = 'accept'.tr;
                    } else if (posts['status'] == 'waiting') {
                      status = 'pending'.tr;
                    }
                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }
                    List order = posts['order'];
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Card(
                        color: Colors.grey[100],
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                //order_id
                               Row(
                                 children: [
                                   const SizedBox(width: 20,),
                                  Custom_Text(
                                      text: 'orderId'.tr,
                                      fontSize: 26,
                                      alignment: Alignment.center,
                                    ),
                                   const SizedBox(width: 10,),
                                   Custom_Text(
                                     text: posts['order_id'],
                                     fontSize: 15,
                                     alignment: Alignment.center,
                                   ),
                                 ],
                               ),
                                const Divider(),
                                Custom_Text(
                                  text: 'addressInfo'.tr,
                                  fontSize: 28,
                                  alignment: Alignment.center,
                                ),
                               Custom_Text(
                                  text: 'address'.tr,
                                  fontSize: 18,
                                  alignment: Alignment.center,
                                ),
                                Custom_Text(
                                    text: posts['address'],
                                    fontSize: 16,
                                    alignment: Alignment.center,
                                    color: Colors.grey),

                                Custom_Text(
                                  text: 'phone'.tr,
                                  fontSize: 18,
                                  alignment: Alignment.center,
                                ),
                                Custom_Text(
                                    text: posts['phone'],
                                    fontSize: 18,
                                    alignment: Alignment.center,
                                    color: Colors.grey),
                              ],
                            ),
                            const Divider(
                              thickness: 0.7,
                              color: Colors.grey,
                            ),
                            (posts['date'] != null)
                                ? Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 11,
                                    ),
                                  Custom_Text(
                                      text: 'date'.tr+" ",
                                      fontSize: 16,
                                      color: ColorsManager.TextColor1,
                                    ),
                                    const SizedBox(
                                      width: 11,
                                    ),
                                    Custom_Text(
                                      text: posts['date'],
                                      fontSize: 16,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 11,
                                    ),
                                    Custom_Text(
                                      text: 'time'.tr+" ",
                                      fontSize: 16,
                                      color: ColorsManager.TextColor1,
                                    ),
                                    const SizedBox(
                                      width: 11,
                                    ),
                                    Custom_Text(
                                      text: posts['time'],
                                      fontSize: 16,
                                      color: Colors.grey,
                                    )
                                  ],
                                )
                              ],
                            )
                                : const SizedBox(),
                            const SizedBox(
                              height: 10,
                            ),
                            Custom_Text(
                              text: 'order'.tr,
                              fontSize: 28,
                              alignment: Alignment.center,
                            ),
                            for (int i = 0; i < order.length; i++)
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                          width: 110,
                                          height: 170,
                                          child: Image.network(order[i]['image'])),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        width:110,
                                        child: Wrap(
                                            children:[
                                              Center(
                                                child: Text(
                                                    order[i]['name'].toString(),
                                                    maxLines:2,
                                                    style: GoogleFonts.tajawal(
                                                      color:ColorsManager.TextColor1,fontSize: 17,fontWeight: FontWeight.bold,
                                                      textBaseline: TextBaseline.alphabetic,
                                                    )
                                                ),
                                              ),
                                            ]
                                        ),
                                      ),

                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Column(
                                        children: [
                                        Custom_Text(
                                              text: 'price'.tr,
                                              fontSize: 16,
                                              alignment: Alignment.center),
                                          Custom_Text(
                                              text: order[i]['price'],
                                              fontSize: 17,
                                              alignment: Alignment.center),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 22,
                                      ),
                                      Custom_Text(
                                          text: " X " + order[i]['quant'],
                                          fontSize: 21,
                                          alignment: Alignment.center),
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 0.7,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                            Custom_Text(
                              text: "total".tr+" "+posts['total']+' '+"currency".tr,
                              fontSize: 25,
                              alignment: Alignment.center,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Column(
                              children: [
                                 Custom_Text(
                                  text: 'orderStatus'.tr,
                                  fontSize: 25,
                                  alignment: Alignment.center,
                                  color: ColorsManager.black,
                                ),
                                const SizedBox(
                                  height: 11,
                                ),
                                Custom_Text(
                                  text: status,
                                  fontSize: 24,
                                  alignment: Alignment.center,
                                  color: Colors.pink,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
          }
        }),
  );
}
