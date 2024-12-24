// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../config/my_config.dart';
import '../viewmodels/controller/auth_viewmodel.dart';
import '../x_router/router_name.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthViewModel _authViewModel = Get.find<AuthViewModel>();

  @override
  void initState() {
    super.initState();
    _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    await Future.delayed(Duration(seconds: 3));

    final String? token = GetStorage().read(MyConfig.ACCESS_TOKEN_KEY);
    if (token != null) {
      try {
        await _authViewModel.getUserInfo(token);
        Get.offAllNamed(RouterName.home);
      } catch (e) {
        print('Error verifying token: $e');
        await _authViewModel.Logout();
      }
    } else {
      Get.offAllNamed(RouterName.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/splash1_img.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        // child: Center(
        //   child: CircularProgressIndicator(
        //     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        //   ),
        // ),
      ),
    );
  }
}
