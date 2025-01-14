// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_shose/viewmodels/controller/shoe_controller.dart';
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
  final ShoeController _shoesViewModel = Get.find<ShoeController>();
  @override
  void initState() {
    super.initState();
    _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    await Future.delayed(Duration(seconds: 3));
    // GetStorage().remove(MyConfig.ACCESS_TOKEN_KEY);
    String? token = GetStorage().read(MyConfig.ACCESS_TOKEN_KEY);
    if (token != null) {
      try {
        _authViewModel.isLoading.value = true;
        await _authViewModel.getUserInfo();
        await _shoesViewModel.fetchShoes();
        await _shoesViewModel.getCart();
        _authViewModel.isLoading.value = false;
        Get.offAllNamed(RouterName.home);
      } catch (e) {
        print('Error verifying token: $e');
        _authViewModel.isLoading.value = false;
        await _authViewModel.Logout();
      }
    } else {
      Get.offAllNamed(RouterName.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/splash1_img.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Obx(() {
              return _authViewModel.isLoading.value
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : SizedBox.shrink();
            }),
          ),
        ],
      ),
    );
  }
}
