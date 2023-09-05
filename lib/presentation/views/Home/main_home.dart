import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shop_app/presentation/views/Home/home_view.dart';
import 'package:shop_app/presentation/views/cart/cart_view.dart';
import 'package:shop_app/presentation/views/instgram/instgram_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../resources/color_manager.dart';
import '../instgram/call.dart';
import 'app_start.dart';

class MainHome extends StatelessWidget {
  const MainHome({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    List<Widget> fragmentScreens = [

    AppStartView(),
      const HomeView(),
      CartView(appBar: false,),
    
      const InstgramView(),
      const CallView(),
    ];
//k
    List navigationButtonProperties = [
      {"active_icon": (Icons.home_filled), "non_active_icon": (Icons.home_filled), "label": " "},
      {"active_icon": (Icons.category), "non_active_icon": (Icons.category_outlined), "label": ""},
      {"active_icon": (Icons.shopping_cart), "non_active_icon": (Icons.add_shopping_cart_outlined), "label": ""},
      {"active_icon": (LineIcons.values['instagram']), "non_active_icon": (LineIcons.values['instagram']), "label": ""},
      {"active_icon":(Icons.messenger_rounded), "non_active_icon": (Icons.messenger_outline_outlined), "label": ""},
    ];

    RxInt indexNumber = 0.obs;

    return Scaffold(
        backgroundColor: ColorsManager.ColorHelper,
        appBar: AppBar(
          toolbarHeight: 1,
          elevation: 0.0,
          backgroundColor: ColorsManager.ColorHelper,
        ),
        body: SafeArea(child: Obx(() => fragmentScreens[indexNumber.value])),
        bottomNavigationBar: Obx(() => Container(

              padding: const EdgeInsets.all(0.0),
              child: BottomNavigationBar(
                currentIndex: indexNumber.value,
                onTap: (value) {
                  indexNumber.value = value;
                },
                showSelectedLabels: true,
                backgroundColor: ColorsManager.primary,
                showUnselectedLabels: true,
                selectedItemColor: ColorsManager.primary,
                unselectedItemColor: Colors.grey,
                items: List.generate(5, (index) {
                  var BtnProp = navigationButtonProperties[index];
                  return BottomNavigationBarItem(
                      backgroundColor: ColorsManager.ColorHelper2,
                      icon:
                      (index==3|| index==4)?
                      InkWell(child: Icon(BtnProp["non_active_icon"],size: 31),
                      onTap:() async {
                        await _openInstagramAccountOrCall(index);
                      }):Icon(BtnProp["non_active_icon"],size: 31),

                      activeIcon: Icon(BtnProp["active_icon"],size: 31,),
                      label: BtnProp["label"]);
                }),
              ),
            )));

  }
}


void openWhatsApp(String phoneNumber, String message) async {
  // The 'whatsapp://' scheme is used to open WhatsApp
  // Replace the country code prefix '+' with '00' for international numbers
  String url = "whatsapp://send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}";

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    await launch(url);
    throw "Could not launch WhatsApp.";
  }
}

Future <void > _openInstagramAccountOrCall(int index) async {


  if(index==3){
    const String instagramAccount = "ophelia.flower1/"; // Replace with the Instagram account username you want to open

    const String instagramUrl = "https://www.instagram.com/$instagramAccount";

    if (await canLaunch(instagramUrl)) {
      await launch(instagramUrl);
    } else {
      await launch(instagramUrl);
      throw 'Could not launch $instagramUrl';
    }
  }else{
    const String phoneNumber = "+966537755534";
    String url = "whatsapp://send?phone=$phoneNumber&text=${Uri.encodeComponent('')}";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      await launch(url);
      throw "Could not launch WhatsApp.";
    }

    // Replace with the phone number you want to call

  }

}
