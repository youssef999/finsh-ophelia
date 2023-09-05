import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shop_app/presentation/views/auth/login_view.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import '../../widgets/Custom_Text.dart';
import 'package:get/get.dart';

class FavProductsView extends StatelessWidget {
  const FavProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 3,
        backgroundColor: ColorsManager.primary,
      ),
      body: ListView(
        children: [
          FavWidget(),
        ],
      ),
    );
  }
}

Widget FavWidget() {
  final box = GetStorage();
  String email = box.read('email') ?? 'x';
  String currency = box.read('currency') ?? 'x';

  if (email == 'x') {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 350,
          child: Image.asset('assets/images/fav3.png'),
        ),
        const SizedBox(
          height: 20,
        ),
        const Custom_Text(
            text: 'قم بتسجيل الدخول',
            fontSize: 30,
            color: ColorsManager.ColorHelper,
            alignment: Alignment.center),
        const SizedBox(
          height: 20,
        ),
        CustomButton(
            text: 'تسجيل دخول',
            onPressed: () {
              Get.to(const LoginView());
            },
            color1: ColorsManager.ColorHelper,
            color2: ColorsManager.primary2)
      ],
    );
  } else {
    return SizedBox(
      height: 120990,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('fav')
              .where('user_email', isEqualTo: email)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.data!.docs.isEmpty) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset('assets/images/fav3.png'),
                      const SizedBox(
                        height: 10,
                      ),
                      const Custom_Text(
                        text: 'لا توجد منتجات في المفضلة الان',
                        fontSize: 27,
                        alignment: Alignment.center,
                        color: ColorsManager.primary,
                      )
                    ],
                  );
                }
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot posts = snapshot.data!.docs[index];
                      if (snapshot.data == null) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 120,
                              child: Image.asset('assets/images/fav.jpg'),
                            )
                          ],
                        );
                      }
                      return InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorsManager.primary),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  height: 130,
                                  width: 222,
                                  child: Image.network(
                                    posts['image'][0],
                                    // fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Column(
                                  children: [
                                    Custom_Text(
                                      text: posts['name'],
                                      fontSize: 17,
                                      alignment: Alignment.center,
                                      fontWeight: FontWeight.bold,
                                      color: ColorsManager.primary2,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RatingBar.builder(
                                      itemSize: 14,
                                      initialRating: double.parse(
                                          posts['rate'].toString()),
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 1.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      unratedColor: Colors.grey,
                                      onRatingUpdate: (rating) {

                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Custom_Text(
                                      text:
                                          "${posts['price']}" + "  " + currency,
                                      fontSize: 17,
                                      alignment: Alignment.center,
                                      color: ColorsManager.primary2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                InkWell(
                                  child: const Icon(
                                    Icons.favorite,
                                    size: 34,
                                    color: Colors.red,
                                  ),
                                  onTap: () {
                                    DeleteFromFav(posts: posts);
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          // Get.to (ProductDetailsView(
                          //   posts: posts,
                          //   tag: 'x'
                          // ));
                        },
                      );
                    });
            }
          }),
    );
  }
}

DeleteFromFav({required DocumentSnapshot posts}) async {
  final CollectionReference _updates =
      FirebaseFirestore.instance.collection('fav');
  await _updates
      .where('productid', isEqualTo: posts['productid'])
      .get()
      .then((snapshot) {
    snapshot.docs.last.reference.delete().then((value) {
      print("Deleted");
    });
  });
}
