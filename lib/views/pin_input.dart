import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shop_shose/viewmodels/controller/auth_viewmodel.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // final _authService = AuthService();
  final _otpController = TextEditingController();
  final AuthViewModel controllerAuth = Get.find();
  // Future<void> _verifyOtp() async {
  //   final otp = _otpController.text;
  //   // final token = await _authService.verifyOtp(otp);
  //   if (token != null) {
  //     Get.offAllNamed(RouterName.home);
  //   } else {
  //     // Show error message
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Invalid OTP')),
  //     );
  //   }
  // }
// final List<CartItem> itemsToPayFor = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'OTP Verification',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Enter the code from the SMS we sent to ${Get.arguments}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            PinCodeTextField(
              appContext: context,
              length: 6,
              onChanged: (value) {
                print("Current value: $value");
              },
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
                selectedFillColor: Colors.white,
                inactiveFillColor: Colors.grey[200]!,
                activeColor: Colors.orange,
                selectedColor: Colors.orange,
                inactiveColor: Colors.grey,
              ),
              animationType: AnimationType.fade,
              controller: _otpController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // print("Entered OTP: ${_otpController.text}");

                await controllerAuth.vetifyOtp(
                    Get.arguments, _otpController.text);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5, // Độ nổi
                shadowColor: Colors.orangeAccent, // Màu bóng
              ),
              child: Text(
                'Verify OTP',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
