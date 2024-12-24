import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_shose/x_router/router_name.dart';

class OrderSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông Báo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 100.sp,
            ),
            SizedBox(height: 20),
            Text(
              'Đặt hàng thành công!',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40.h),
            ElevatedButton(
              child: Text('Trở về trang chủ'),
              onPressed: () => Get.offAllNamed(RouterName.home),
            ),
          ],
        ),
      ),
    );
  }
}
