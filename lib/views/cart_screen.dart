import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_shose/config/my_config.dart';
import 'package:shop_shose/viewmodels/controller/shoe_controller.dart';
import '../models/cart_item.dart';

class CartScreen extends StatelessWidget {
  final ShoeController shoeController = Get.find<ShoeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ Hàng'),
      ),
      body: Obx(() {
        if (shoeController.filteredCartItem.value.isEmpty) {
          return Center(child: Text('Không có sản phẩm nào'));
        } else {
          return ListView.builder(
            itemCount: shoeController.filteredCartItem.value.length,
            itemBuilder: (context, index) {
              return CartItemWidget(
                  cartItem: shoeController.filteredCartItem.value[index]);
            },
          );
        }
      }),
      bottomNavigationBar: Obx(() {
        double total = shoeController.filteredCartItem.value.fold(0,
            (sum, item) => sum + (item.price)); // Replace 100 with actual price
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            child: Text('Tổng Cộng: (\$${total.toStringAsFixed(2)})'),
            onPressed: () {
              shoeController.proceedToPayment();
              // Implement checkout logic
            },
          ),
        );
      }),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final ShoeController shoeController = Get.find<ShoeController>();

  CartItemWidget({required this.cartItem});
  void _handlePayment() {
    shoeController.proceedToPaymentSingle(cartItem);
    // Get.snackbar(
    //   'Payment',
    //   'Processing payment for ${cartItem.name}',
    //   snackPosition: SnackPosition.BOTTOM,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(cartItem.image),
          ),
        ),
      ),
      title: Text('Giá: ${cartItem.price}'),
      subtitle:
          Text('Kích cỡ: ${cartItem.size}, Số lượng: ${cartItem.quantity}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.payment, color: Colors.green),
            onPressed: _handlePayment,
            tooltip: 'Pay for this item',
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              shoeController.remotefromCart(GetStorage().read(MyConfig.ID_USER),
                  cartItem.idProduct, cartItem.size);
            },
            tooltip: 'Remove from cart',
          ),
        ],
      ),
    );
  }
}
