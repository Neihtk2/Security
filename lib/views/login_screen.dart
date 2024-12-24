import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_shose/viewmodels/controller/auth_viewmodel.dart';
import 'package:shop_shose/x_router/router_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthViewModel controllerAuth = Get.find();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  bool _pass = true;
  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumberController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/login.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        // color: Colors.deepPurpleAccent,
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            SizedBox(
              child: Text(
                'Hello Again!',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
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
                    icon: Icon(
                        _pass ? CupertinoIcons.eye_slash : CupertinoIcons.eye),
                    onPressed: () {
                      setState(() {
                        _pass = !_pass;
                      });
                    },
                  )),
            ),
            SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Quên mật khẩu?'),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            InkWell(
              child: Container(
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: Colors.blue),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: _isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Đăng nhập',
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 20),
                          ),
                  )),
              onTap: () {
                controllerAuth.login(
                    phoneNumberController.text, passController.text);
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
                  child: Text("Bạn chưa có tài khoản?"),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  child: Container(
                    child: Text(
                      "Đăng ký",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  onTap: () {
                    Get.toNamed(RouterName.signin);
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
    ));
  }
}
