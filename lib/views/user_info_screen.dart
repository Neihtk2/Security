import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_shose/viewmodels/controller/auth_viewmodel.dart';

class UserInfoScreen extends StatelessWidget {
  final AuthViewModel userController = Get.find<AuthViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (userController.userinfo.value == null) {
          return Center(child: Text('No user information available'));
        } else {
          final user = userController.userinfo.value!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoTile('ID', user.id.toString()),
                _buildInfoTile('Tên', user.name),
                _buildInfoTile('Số Điện Thoại', user.phoneNumber ?? 'Not provided'),
                SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: () {
                //     // TODO: Implement edit functionality
                //     Get.snackbar(
                //         'Edit', 'Edit functionality not implemented yet');
                //   },
                //   child: Text('Edit Information'),
                // ),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 18),
          ),
          Divider(),
        ],
      ),
    );
  }
}
