import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shop_shose/models/get_oder.dart';
import 'package:shop_shose/models/oder.dart';
import 'package:shop_shose/viewmodels/controller/shoe_controller.dart';
import 'package:shop_shose/x_router/router_name.dart';

class OrderHistoryScreen extends StatelessWidget {
  final ShoeController shoeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử đơn hàng'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (shoeController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (shoeController.getorders.value.isEmpty) {
          return Center(child: Text('Bạn chưa có đơn hàng nào'));
        } else {
          return ListView.builder(
            itemCount: shoeController.getorders.value.length,
            itemBuilder: (context, index) {
              return OrderItemWidget(
                  order: shoeController.getorders.value[index]);
            },
          );
        }
      }),
    );
  }

  // @override
  // void  onInit{
  //   shoeController.getAllOrders();
  // }
}

class OrderItemWidget extends StatelessWidget {
  final ShoeController shoeController = Get.find();
  final Datum order;
  OrderItemWidget({required this.order});
  // String covertdate(String date) {
  //   DateTime dateTime = DateTime.parse(date);
  //   String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  //   return formattedDateTime;
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          'Đơn hàng #${order.id}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text('Thời gian: ${(order.orderDate)}'),
            Text('Trạng Thái: ${order.status}'),
            Text('Phương thức thanh toán: ${order.payment}'),
            SizedBox(height: 8),
            Text(
              'Tổng Tiền: ${order.totalPrice.toStringAsFixed(2)}đ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          shoeController.getOrderDetails(order.id);
          Get.toNamed(RouterName.getdetailoder);
        },
      ),
    );
  }
}
