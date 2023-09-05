

 import 'package:flutter/material.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    const String longText = '''
   الأحكام والشروط 
عملائنا الكرام تم تحديد الاحكام والشروط أدناه لضمان جودة خدماتنا ومنتجاتنا وعليه نرجوا منكم قراءة الشروط والاحكام قبل تنفيذ عملية الشراء وفيما يلي الشروط : 

أولا : الشروط العامة. .
 يتم تنفيذ الطلب بعد اعتماد العميل و التأكيد عليه و سداد المبلغ خلال ساعة أثناء أوقات العمل وفي حال تم الطلب في اخر  ساعة  من ساعات العمل يتم تأجيل تنفيذ الطلب لليوم التالي. . 

أوقات العمل من الساعة 4 مساءً  الى الساعة 11ونصف  مساءً وفي هذه الأوقات يتم تسليم وتوصيل الطلبات لأيام العمل وفقاً للساعات العمل اليومي 
 عدا شهر رمضان المبارك. . 


ثانياً : سياسة الاسترجاع : . 
. المنتجات القابلة للتلف مع الوقت مثل الورد الطبيعي, الأطعمة, لا يمكن ارجاع اي طلب يحتوي على هذه العناصر. . 
يتم طلب الاسترجاع من خلال التواصل مع خدمة العملاء  وان يكون المنتج والتغليف في حالته الأصليه خلال مدة 24 ساعة من وقت الطلب ويتم تسجل البيانات و المعلومات ورقم حساب البنكي ليتم تحويل قيمة الارجاع بعد مراجعة وموافقة خدمة فريق العملاء.
ثالثاً : سياسة الخصوصية : 
 لا نقوم بجمع البيانات لغرض بيعها او نشرها و انما انت توافق على جمع بياناتك لغرض اتمام الطلب وارسالها لطرف ثالث على سبيل المثال لا الحصر مثل شركات الشحن و الدفع الالكتروني و الرسائل القصيرة.
 رابعاً : لخدمة العملاء و الشكاوي ارجوا الاتصال او ارسال واتس اب الى الرقم التالي: 
966537755534
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
              Custom_Text(text: 'Privacy Policy',
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
