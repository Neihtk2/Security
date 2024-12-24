import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_shose/viewmodels/controller/auth_viewmodel.dart';
import 'package:shop_shose/x_router/router_name.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final AuthViewModel controllerAuth = Get.find();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameUserController = TextEditingController();
  TextEditingController emailUserController = TextEditingController();
  bool _pass = true;
  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumberController.dispose();
    passController.dispose();
    nameUserController.dispose();
    emailUserController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Image.asset(
            'assets/image/signin.jpg', // Đường dẫn đến hình ảnh của bạn
            fit: BoxFit.cover, // Đảm bảo hình ảnh phủ toàn bộ màn hình
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.all(20.0.r),
            child: Container(
              // color: Colors.deepPurpleAccent,
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(),
                    flex: 2,
                  ),
                  SizedBox(
                    child: Text(
                      'Creat Account',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 24.sp),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                        hintText: 'Mời nhập số điện thoại',
                        filled: true,
                        focusedBorder: inputBorder,
                        border: inputBorder,
                        enabledBorder: inputBorder,
                        labelText: 'Số điện thoại',
                        // labelStyle: TextStyle(fontSize: 5),
                        prefixIcon: Icon(Icons.phone_android)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    obscureText: _pass,
                    controller: passController,
                    decoration: InputDecoration(
                        hintText: 'Mời nhập mật khẩu',
                        filled: true,
                        focusedBorder: inputBorder,
                        border: inputBorder,
                        enabledBorder: inputBorder,
                        labelText: 'Mật khẩu',
                        // labelStyle: TextStyle(fontSize: 5),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(_pass
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye),
                          onPressed: () {
                            setState(() {
                              _pass = !_pass;
                            });
                          },
                        )),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: nameUserController,
                    decoration: InputDecoration(
                        hintText: 'Mời nhập tên người dùng',
                        filled: true,
                        focusedBorder: inputBorder,
                        border: inputBorder,
                        enabledBorder: inputBorder,
                        labelText: 'Tên người dùng',
                        // labelStyle: TextStyle(fontSize: 5),
                        prefixIcon: Icon(Icons.person)),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: emailUserController,
                    decoration: InputDecoration(
                        hintText: 'Mời nhập Email',
                        filled: true,
                        focusedBorder: inputBorder,
                        border: inputBorder,
                        enabledBorder: inputBorder,
                        labelText: 'Email',
                        // labelStyle: TextStyle(fontSize: 5),
                        prefixIcon: Icon(Icons.mail_outline)),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  InkWell(
                    child: Container(
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.r)),
                            ),
                            color: Colors.blue),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Center(
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Đăng ký',
                                  style: TextStyle(
                                      color: Colors.grey[400], fontSize: 20.sp),
                                ),
                        )),
                    onTap: () {
                      controllerAuth.signin(
                          nameUserController.text,
                          passController.text,
                          emailUserController.text,
                          phoneNumberController.text);
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Flexible(
                    child: Container(),
                    flex: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text("Bạn đã có tài khoản?"),
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        child: Container(
                          child: Text(
                            "Đăng nhập",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 8),
                        ),
                        onTap: () {
                          Get.offNamed(RouterName.login);
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
