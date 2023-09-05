


import 'package:flutter/material.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    const String longText = '''
   من نحن
 أوفيليا  يعد واحد من أقوى وأجود متاجر الورد والزهور الطبيعيه  في المنطقه ، نحرص دائما على تقديم أفضل المنتجات وأقوى الخدمات حيث إنتهجنا معايير عالية لنضمن التميز لمنتجاتنا، كما أنه يوجد لدينا فريق عمل من المصممين المحترفين لمنتاجاتنا وتعد التصاميم و الجودة من أهم أولوياتنا ونسعى دائما للوصول لأعلى مستويات التميز من حيث ثقة عملائنا
أين موقع المتجر وهل لديكم محل او معرض؟
أوفيليا  هو متجر  الكتروني و علامة تجارية سعودية تتبع لمؤسسة أوفيليا للزهور  نسعد بتلبية طلبات عملائنا حيث نوفر الزهور  المميزة ، عبر خدمة التوصيل ونغطي  محافظة الدرب وما حولها .
عن طريق خدمة التوصيل من أوفيليا برسوم رمزية 
وقريباً سيتم تغطية مناطق أخرى
  ''';
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 55,
          backgroundColor:ColorsManager.ColorHelper
      ),
      body:const SingleChildScrollView(
        child:
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 22,),
              Custom_Text(text: 'About Us',
                alignment:Alignment.center,
                fontWeight: FontWeight.bold,
                fontSize: 25,color:ColorsManager.black,
              ),
              SizedBox(height: 22,),
              Custom_Text(text: longText,
                alignment:Alignment.center,
                fontSize: 16,color:ColorsManager.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
