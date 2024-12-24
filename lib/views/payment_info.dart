import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_shose/models/payment_button.dart';
import 'package:shop_shose/viewmodels/controller/shoe_controller.dart';
import '../models/payment_info.dart';
import '../models/cart_item.dart';

class PaymentInfoScreen extends StatelessWidget {
  final ShoeController shoeController = Get.find<ShoeController>();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final List<CartItem> itemsToPayFor = Get.arguments;
  final RxString paymentMethod = 'vnpay'.obs;

  @override
  Widget build(BuildContext context) {
    double totalPrice = itemsToPayFor.fold(
        0, (sum, item) => sum + (item.price * item.quantity));

    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin thanh toán'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.all(16.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Địa chỉ giao hàng',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Số điện thoại',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 24.h),
                Text('Sản phẩm:',
                    style: TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.bold)),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: itemsToPayFor.length,
                  itemBuilder: (context, index) {
                    CartItem item = itemsToPayFor[index];
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text(
                          'Kích cỡ: ${item.size}, Số lượng: ${item.quantity}'),
                      trailing: Text(
                          '${(item.price * item.quantity).toStringAsFixed(2)}đ'),
                    );
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Tổng cộng: \$${totalPrice.toStringAsFixed(2)}',
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 24.h),
                Text('Phương thức thanh toán:',
                    style: TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.bold)),
                Obx(() => Column(
                      children: [
                        RadioListTile<String>(
                          title: Text('Thanh toán online'),
                          value: 'vnpay',
                          groupValue: paymentMethod.value,
                          onChanged: (value) => paymentMethod.value = value!,
                        ),
                        RadioListTile<String>(
                          title: Text('Thanh toán tiền mặt khi nhận hàng'),
                          value: 'cash',
                          groupValue: paymentMethod.value,
                          onChanged: (value) => paymentMethod.value = value!,
                        ),
                      ],
                    )),
                SizedBox(height: 24.h),
                PaymentButton(
                  onPressed: () async {
                    if (addressController.text.isEmpty ||
                        phoneController.text.isEmpty) {
                      Get.snackbar('Lỗi', 'Vui lòng điền đầy đủ thông tin');
                      return;
                    }
                    PaymentInfo paymentInfo = PaymentInfo(
                      address: addressController.text,
                      phoneNumber: phoneController.text,
                    );
                    paymentMethod.value == 'vnpay'
                        ? shoeController.processPayment(
                            paymentInfo, itemsToPayFor)
                        : shoeController.processCash(
                            paymentInfo, itemsToPayFor);
                    await shoeController.getCart();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
