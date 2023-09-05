import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';

class UserOrdersView extends StatelessWidget {
  const UserOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          backgroundColor: ColorsManager.primary,
          title: const Custom_Text(
            text: ' طلباتي السابقة  ',
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
  String email = box.read('email') ?? "x";
  String currency = box.read('currency') ?? "x";

  return Container(
    height: 76600,
    color: ColorsManager.primary2,
    child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('user_email', isEqualTo: email)
            .orderBy('date', descending: true)
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
                      status = 'ملغي';
                    } else if (posts['status'] == 'accept') {
                      status = 'تم الموافقة علي الطلب';
                    } else if (posts['status'] == 'waiting') {
                      status = 'بانتظار الموافقة';
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
                                const Custom_Text(
                                  text: 'بيانات العنوان',
                                  fontSize: 28,
                                  alignment: Alignment.center,
                                ),
                                const Custom_Text(
                                  text: 'العنوان',
                                  fontSize: 18,
                                  alignment: Alignment.center,
                                ),
                                Custom_Text(
                                    text: posts['address'],
                                    fontSize: 16,
                                    alignment: Alignment.center,
                                    color: Colors.grey),
                                const Custom_Text(
                                  text: 'المبني ',
                                  fontSize: 18,
                                  alignment: Alignment.center,
                                ),
                                Custom_Text(
                                    text: posts['home'],
                                    fontSize: 16,
                                    alignment: Alignment.center,
                                    color: Colors.grey),
                                const Custom_Text(
                                  text: 'الطابق ',
                                  fontSize: 18,
                                  alignment: Alignment.center,
                                ),
                                Custom_Text(
                                    text: posts['floor'],
                                    fontSize: 18,
                                    alignment: Alignment.center,
                                    color: Colors.grey),
                                const Custom_Text(
                                  text: 'الهاتف ',
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
                                          const Custom_Text(
                                            text: 'تاريخ الطلب',
                                            fontSize: 16,
                                            color: ColorsManager.primary,
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
                                          const Custom_Text(
                                            text: 'توقيت الطلب',
                                            fontSize: 16,
                                            color: ColorsManager.primary,
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
                            const Custom_Text(
                              text: 'الطلب ',
                              fontSize: 28,
                              alignment: Alignment.center,
                            ),
                            for (int i = 0; i < order.length; i++)
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 11,
                                      ),
                                      SizedBox(
                                          width: 110,
                                          height: 170,
                                          child: Image.network(order[i]['image'])),
                                      const SizedBox(
                                        width: 11,
                                      ),
                                      SizedBox(
                                        width:150,
                                        child: Wrap(
                                            children:[
                                              Center(
                                                child: Text(
                                              order[i]['name'].toString(),
                                                    maxLines:2,
                                                    style: GoogleFonts.tajawal(
                                                      color:ColorsManager.primary,fontSize: 15,fontWeight: FontWeight.bold,
                                                      textBaseline: TextBaseline.alphabetic,
                                                    )
                                                ),
                                              ),
                                            ]
                                        ),
                                      ),

                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        children: [
                                          const Custom_Text(
                                              text: 'السعر',
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
                              text: "${"الاجمالي = " + posts['total']} $currency",
                              fontSize: 25,
                              alignment: Alignment.center,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Column(
                              children: [
                                const Custom_Text(
                                  text: 'حالة الطلب ',
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
