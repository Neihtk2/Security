import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_shose/models/oder_detail.dart';
import 'package:shop_shose/viewmodels/controller/shoe_controller.dart';

class OderDetailScreen extends StatelessWidget {
  final ShoeController shoeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết đơn hàng'),
      ),
      body: Obx(() {
        if (shoeController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: shoeController.oderdetail.value.length,
            itemBuilder: (context, index) {
              return OrderDetailItemWidget(
                  order: shoeController.oderdetail.value[index]);
            },
          );
        }
      }),
    );
  }
}

class OrderDetailItemWidget extends StatelessWidget {
  final OderDetail order;
  OrderDetailItemWidget({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          'Tên sản phẩm: ${order.name}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Image.network(order.image),
            Text('Size: ${order.size}'),
            SizedBox(height: 8),
            Text(
              'Số Lượng: ${order.quantity}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
