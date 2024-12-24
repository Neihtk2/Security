import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_shose/viewmodels/controller/shoe_controller.dart';

class PaymentButton extends StatelessWidget {
  final VoidCallback onPressed;
  PaymentButton({required this.onPressed, Key? key}) : super(key: key);
  final ShoeController shoeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 5, // Độ nổi
        shadowColor: Colors.greenAccent, // Màu bóng
      ),
      child: Obx(() => shoeController.isLoading.value
          ? SizedBox(
              height: 24.h,
              width: 24.h,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.payment,
                    color: Colors.white), // Biểu tượng thanh toán
                SizedBox(width: 8),
                Text(
                  "Thanh Toán",
                  style: TextStyle(
                    color: Colors.white, // Màu chữ
                    fontSize: 16, // Kích thước chữ
                    fontWeight: FontWeight.bold, // Đậm chữ
                  ),
                ),
              ],
            )),
    );
  }
}
