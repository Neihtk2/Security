import 'package:flutter/material.dart';
import 'package:shop_shose/services/api_service.dart';
import 'package:shop_shose/viewmodels/controller/auth_viewmodel.dart';
import 'package:shop_shose/viewmodels/controller/shoe_controller.dart';
import 'package:shop_shose/x_router/router_name.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final ApiService _apiService = ApiService();
  final AuthViewModel userController = Get.find();
  late final WebViewController _controller;
  bool _isLoading = true;
  final ShoeController shoeController = Get.find();
  @override
  void initState() {
    print('Get.arguments: ${Get.arguments}');
    super.initState();
    final String paymentUrl = Get.arguments['paymentUrl'] is String
        ? Get.arguments['paymentUrl']
        : 'https://www.youtube.com/';
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url
                .contains("https://next-shop-gules.vercel.app/query-payment")) {
              Uri uri = Uri.parse(request.url);
              String transactionStatus =
                  uri.queryParameters['vnp_ResponseCode'] ?? '';
              String transactionId =
                  uri.queryParameters['vnp_TransactionNo'] ?? '';
              if (transactionStatus == '00') {
                _handlePaymentSuccess();
                Get.offNamed(RouterName.donecash);
              } else {
                Navigator.pop(
                    context, "Thanh toán thất bại, mã lỗi: $transactionStatus");
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(paymentUrl));
  }

  Future<void> _handlePaymentSuccess() async {
    try {
      await _apiService.postOrder(
          Get.arguments['order'], userController.token.value);
      await shoeController.getCart();
      await shoeController.getAllOrders();
    } catch (e) {
      print('Lỗi xử lý sau khi thanh toán thành công: $e');
      throw Exception('Xử lý sau thanh toán thất bại.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
