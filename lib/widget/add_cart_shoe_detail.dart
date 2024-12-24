// // //
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:shop_shose/config/my_config.dart';
// import 'package:shop_shose/viewmodels/controller/auth_viewmodel.dart';
// import 'package:shop_shose/viewmodels/controller/shoe_controller.dart';
// import '../models/shoes_model.dart';

// class AddCartShoeDetail extends StatelessWidget {
//   final Shoes shoe;

//   AddCartShoeDetail({required this.shoe});
//   final ShoeController shoeController = Get.find();
//   final AuthViewModel userController = Get.find();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.85,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header with close button
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           '${shoe.price}đ',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.red,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           shoe.name!,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           'In stock: ${shoe.quantity}',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.green,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.close),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ],
//               ),
//             ),

//             // Image
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.network(
//                   shoe.image!,
//                   width: double.infinity,
//                   height: 200,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),

//             // Size options
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Kích cỡ',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 12),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: [
//                         for (var size in ['39', '40', '41', '42', '43', '44'])
//                           Padding(
//                             padding: const EdgeInsets.only(right: 8.0),
//                             child: _buildSizeOption(size),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Quantity selector
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Số lượng',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 12),
//                   Container(
//                     child: Row(
//                       children: [
//                         IconButton(
//                           icon: Icon(
//                             Icons.remove,
//                             color: Colors.black,
//                           ),
//                           onPressed: () => shoeController.quantity.value > 1
//                               ? shoeController.quantity.value--
//                               : null,
//                         ),
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 12),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: Obx(() => Text(
//                                 '${shoeController.quantity.value}',
//                                 style: TextStyle(fontSize: 16),
//                               )),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.add, color: Colors.black),
//                           onPressed: () => shoeController.quantity.value++,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Buy button
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (shoeController.selectedSize.value.isEmpty) {
//                     Get.snackbar('Error', 'Please select a size');
//                     return;
//                   }
//                   shoeController.addToCart(
//                       GetStorage().read(MyConfig.ACCESS_TOKEN_KEY),
//                       shoe.id.toString(),
//                       shoeController.selectedSize.value,
//                       shoeController.quantity.value);
//                   // Implement buy with voucher functionality
//                   Get.back();
//                   Get.snackbar('Success', 'Processing your order',
//                       snackPosition: SnackPosition.BOTTOM);
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                   child: Text(
//                     'ADD',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSizeOption(String size, {bool enabled = true}) {
//     return Obx(() => GestureDetector(
//           onTap:
//               enabled ? () => shoeController.selectedSize.value = size : null,
//           child: Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: shoeController.selectedSize.value == size
//                     ? Colors.blue
//                     : Colors.grey,
//                 width: shoeController.selectedSize.value == size ? 2 : 1,
//               ),
//               borderRadius: BorderRadius.circular(8),
//               color: enabled ? Colors.white : Colors.grey.withOpacity(0.1),
//             ),
//             child: Center(
//               child: Text(
//                 size,
//                 style: TextStyle(
//                   color: enabled ? Colors.black : Colors.grey,
//                   fontWeight: shoeController.selectedSize.value == size
//                       ? FontWeight.bold
//                       : FontWeight.normal,
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../config/my_config.dart';
import '../viewmodels/controller/auth_viewmodel.dart';
import '../viewmodels/controller/shoe_controller.dart';
import '../models/shoes_model.dart';

class AddCartShoeDetail extends StatelessWidget {
  final Shoes shoe;

  AddCartShoeDetail({required this.shoe});
  final ShoeController shoeController = Get.find();
  final AuthViewModel userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.905,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            _buildImage(),
            _buildSizeOptions(),
            _buildQuantitySelector(),
            _buildAddToCartButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${shoe.price}đ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  shoe.name!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 4),
                Obx(() => Text(
                      'Số lượng: ${shoeController.remainingQuantity.value}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    )),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          shoe.image!,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSizeOptions() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kích cỡ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var size in ['39', '40', '41', '42', '43', '44'])
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: _buildSizeOption(size),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Số lượng',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.remove,
                    color: Colors.black,
                  ),
                  onPressed: () => shoeController.quantity.value > 1
                      ? shoeController.quantity.value--
                      : null,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Obx(() => Text(
                        '${shoeController.quantity.value}',
                        style: TextStyle(fontSize: 16),
                      )),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.black),
                  onPressed: () {
                    if (shoeController.quantity.value <
                        shoeController.remainingQuantity.value!) {
                      shoeController.quantity.value++;
                    } else {
                      Get.snackbar(
                        'Maximum Quantity Reached',
                        'You cannot add more than the available stock.',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          if (shoeController.selectedSize.value.isEmpty) {
            Get.snackbar('Lỗi', 'Vui lòng chọn kích cỡ');
            return;
          }
          if (shoeController.quantity.value >
              shoeController.remainingQuantity.value!) {
            Get.snackbar('Lỗi', 'Số lượng không có sẵn');
            return;
          }
          shoeController.addToCart(
            GetStorage().read(MyConfig.ACCESS_TOKEN_KEY),
            shoe.id.toString(),
            shoeController.selectedSize.value,
            shoeController.quantity.value,
          );
          Navigator.pop(context);
          Get.snackbar(
            'Thành công',
            'Đã thêm vào giỏ hàng',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'Thêm vào giỏ hàng',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildSizeOption(String size, {bool enabled = true}) {
    return Obx(() => GestureDetector(
          onTap: () {
            enabled ? shoeController.selectedSize.value = size : null;
            shoeController.getQuantity(shoe.id.toString(), size);
          },
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(
                color: shoeController.selectedSize.value == size
                    ? Colors.blue
                    : Colors.grey,
                width: shoeController.selectedSize.value == size ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(8),
              color: enabled ? Colors.white : Colors.grey.withOpacity(0.1),
            ),
            child: Center(
              child: Text(
                size,
                style: TextStyle(
                  color: enabled ? Colors.black : Colors.grey,
                  fontWeight: shoeController.selectedSize.value == size
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ),
        ));
  }
}
