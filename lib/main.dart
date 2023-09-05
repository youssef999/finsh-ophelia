import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/localization/local.dart';
import 'package:shop_app/localization/local_controller.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/splash_view.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_obs.dart';

void main()async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

 class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final box=GetStorage();
   //en //ar
   String keylocal=box.read('locale')??'';

   ///en //ar //' '

    Locale lang = const Locale('ar');

    if(keylocal!=''){
      lang=Locale(keylocal);
     // box.write('locale', 'en');
    }
    else{
      box.write('locale','ar');
     // lang=const Locale('ar');
    }


    Get.put(LocaleController());
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
    // textDirection:TextDirection.ltr,
      title: 'OPHELIA',
      color:ColorsManager.primary,
      theme: ThemeData(
        primarySwatch: Colors.red,
        appBarTheme:const AppBarTheme(color:ColorsManager.primary)
      ),
      locale:lang,
      //Get.deviceLocale,
      translations: MyLocal(),
      home://FavProductsView()
     const SplashView()
    );
  }
}


