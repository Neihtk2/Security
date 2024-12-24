import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_shose/viewmodels/controller/auth_viewmodel.dart';
import 'package:shop_shose/viewmodels/controller/shoe_controller.dart';
import 'package:shop_shose/x_res/app_themes.dart';
import 'package:shop_shose/x_router/pages.dart';
import 'package:shop_shose/x_router/router_name.dart';

void main() async {
  await GetStorage.init();
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(AuthViewModel());
    Get.put(ShoeController());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(412, 915),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          theme: AppThemes.theme(),
          darkTheme: AppThemes.darkTheme(),
          themeMode: AppThemes().init(),
          initialRoute: RouterName.splash,
          debugShowCheckedModeBanner: false,
          getPages: Pages.pages(),
        );
      },
    );
  }
}
