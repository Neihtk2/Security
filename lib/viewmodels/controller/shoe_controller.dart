import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:shop_shose/config/my_config.dart';
import 'package:shop_shose/models/cart_item.dart';
import 'package:shop_shose/models/get_oder.dart';
import 'package:shop_shose/models/oder.dart';
import 'package:shop_shose/models/oder_detail.dart';
import 'package:shop_shose/models/payment_info.dart';
import 'package:shop_shose/models/shoes_model.dart';
import 'package:shop_shose/services/api_service.dart';
import 'package:shop_shose/viewmodels/controller/auth_viewmodel.dart';
import 'package:shop_shose/x_router/router_name.dart';

class ShoeController extends GetxController {
  final ApiService _apiService = ApiService();
  final AuthViewModel userController = Get.find();
  // var shoesData = Rx<ShoesData?>(null);
  var filteredShoes = <Shoes>[].obs;
  var isLoading = true.obs;
  var currentBannerIndex = 0.obs;
  var filteredCartItem = <CartItem>[].obs;
  var orders = <Order>[].obs;
  var getorders = <Datum>[].obs;
  final RxString selectedSize = ''.obs;
  final RxInt quantity = 1.obs;
  var oderdetail = <OderDetail>[].obs;
  var shoes = <Shoes>[].obs;
  var remainingQuantity = 0.obs;
  var isLoadingPayment = false.obs;
  Future<void> getCart() async {
    try {
      isLoading(true);
      var fetchedShoesData =
          await _apiService.getCart(userController.token.value);
      // cartItems.value = fetchedShoesData;
      filteredCartItem.assignAll(fetchedShoesData.data);
    } finally {
      isLoading(false);
    }
  }

  // Future<void> placeOrder(Order order) async {
  //   try {
  //     isLoading(true);
  //     final paymentUrl = await _apiService.createPayment(
  //         order.totalPrice, userController.token.value);
  //     // await _apiService.postOrder(order, userController.token.value);
  //     isLoading(false);
  //     // Get.snackbar('Thành công', 'Đơn hàng đã được đặt thành công');
  //     Get.toNamed(RouterName.payment, arguments: paymentUrl);
  //   } catch (e) {
  //     isLoading(false);
  //     Get.snackbar(
  //       'Thông báo',
  //       'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
  //       snackPosition: SnackPosition.TOP,
  //     );
  //     await GetStorage().remove(MyConfig.ACCESS_TOKEN_KEY);
  //     Get.offAllNamed(RouterName.login);
  //     // Get.snackbar('Lỗi', 'Không thể đặt hàng: $e');
  //   }
  // }

  // Future<String> createPayment(int amount) async {
  //   return await _apiService.createPayment(amount, userController.token.value);
  // }

  Future<void> remotefromCart(int idUser, int idProduct, int size) async {
    await _apiService.remotefromCart(
        idUser, idProduct, size, userController.token.value);
    await getCart(); // Refresh orders after creating new one
  }

  Future<void> fetchShoes() async {
    try {
      isLoading(true);
      var fetchedShoesData =
          await _apiService.getShoes(userController.token.value);
      // shoesData.value = fetchedShoesData;
      shoes.assignAll(fetchedShoesData.data);
      filteredShoes.assignAll(fetchedShoesData.data);
    } catch (e) {
      print('Error fetching shoes: $e');
    } finally {
      isLoading(false);
    }
  }

  // void filterShoes(String query) {
  //   if (shoesData.value != null) {
  //     filteredShoes.assignAll(
  //       shoesData.value!.data.where((shoe) =>
  //           shoe.name!.toLowerCase().contains(query.toLowerCase()) ||
  //           shoe.brand!.toLowerCase().contains(query.toLowerCase())),
  //     );
  //   }
  // }

  void updateBannerIndex(int index) {
    currentBannerIndex.value = index;
  }

  Future<void> addToCart(
      String token, String productId, String size, int quantity) async {
    await _apiService.addToCart(token, productId, size, quantity);
    await getCart();
  }

  @override
  void onInit() {
    super.onInit();
    // fetchShoes();
    // getCart();
    // getAllOrders();
  }

  void proceedToPayment() {
    if (filteredCartItem.value.isEmpty) {
      Get.snackbar('Lỗi', 'Vui lòng chọn ít nhất một sản phẩm để thanh toán');
    }
    Get.toNamed(RouterName.placement, arguments: filteredCartItem.value);
  }

  void proceedToPaymentSingle(CartItem item) {
    Get.toNamed(RouterName.placement, arguments: [item]);
  }

  Future<void> processPayment(
      PaymentInfo paymentInfo, List<CartItem> items) async {
    try {
      isLoading(true);
      int userId = userController.userinfo.value!.id;
      if (userId == null) {
        throw Exception('Người dùng chưa đăng nhập');
      }
      int totalPrice =
          items.fold(0, (sum, item) => sum + (item.price * item.quantity));
      Order order = Order(
        idUser: userId,
        orderDate: DateTime.now().toIso8601String(),
        address: paymentInfo.address,
        phoneNumber: paymentInfo.phoneNumber,
        totalPrice: totalPrice,
        payment: 'vnpay',
        status: 'Đã đặt hàng',
        products: items
            .map((item) => OrderProduct(
                  idProduct: item.idProduct,
                  size: item.size,
                  quantity: item.quantity,
                ))
            .toList(),
      );

      String paymentUrl = await _apiService.createPayment(
          totalPrice, userController.token.value);
      Get.toNamed(RouterName.payment, arguments: {
        'paymentUrl': paymentUrl,
        'order': order,
      });
    } catch (e) {
      print('Lỗi xử lý thanh toán: $e');
      Get.snackbar(
        'Thông báo',
        'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
        snackPosition: SnackPosition.TOP,
      );
      await GetStorage().remove(MyConfig.ACCESS_TOKEN_KEY);
      Get.offAllNamed(RouterName.login);
      // Get.snackbar('Lỗi', 'Không thể xử lý thanh toán');
    } finally {
      isLoading(false);
    }
  }

  Future<void> processCash(
      PaymentInfo paymentInfo, List<CartItem> items) async {
    try {
      isLoading(true);
      int userId = userController.userinfo.value!.id;
      if (userId == null) {
        throw Exception('Người dùng chưa đăng nhập');
      }
      int totalPrice =
          items.fold(0, (sum, item) => sum + (item.price * item.quantity));
      Order order = Order(
        idUser: userId,
        orderDate: DateFormat('HH:mm dd-MM-yyyy').format(DateTime.now()),
        address: paymentInfo.address,
        phoneNumber: paymentInfo.phoneNumber,
        totalPrice: totalPrice,
        payment: 'cash',
        status: 'Đã đặt hàng',
        products: items
            .map((item) => OrderProduct(
                  idProduct: item.idProduct,
                  size: item.size,
                  quantity: item.quantity,
                ))
            .toList(),
      );
      await _apiService.postOrder(order, userController.token.value);
      await getCart();
      await getAllOrders();
      Get.offNamed(RouterName.donecash);
    } catch (e) {
      print('Lỗi xử lý thanh toán: $e');
      Get.snackbar(
        'Thông báo',
        'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
        snackPosition: SnackPosition.TOP,
      );
      await GetStorage().remove(MyConfig.ACCESS_TOKEN_KEY);
      Get.offAllNamed(RouterName.login);
      // Get.snackbar('Lỗi', 'Không thể xử lý thanh toán');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getAllOrders() async {
    try {
      isLoading(true);
      int userId = userController.userinfo.value!.id;
      if (userId != null) {
        var fetchedOrders =
            await _apiService.getAllOrders(userId, userController.token.value);
        getorders.value = fetchedOrders;
      }
    } catch (e) {
      Get.snackbar(
        'Thông báo',
        'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
        snackPosition: SnackPosition.TOP,
      );
      await GetStorage().remove(MyConfig.ACCESS_TOKEN_KEY);
      Get.offAllNamed(RouterName.login);
      print('Error fetching orders: $e');
      // Get.snackbar('Lỗi', 'Không thể lấy danh sách đơn hàng');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getOrderDetails(int orderId) async {
    try {
      isLoading(true);
      var fetchedOrders = await _apiService.getOrderDetails(
          orderId, userController.token.value);
      oderdetail.value = fetchedOrders;
    } catch (e) {
      Get.snackbar(
        'Thông báo',
        'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
        snackPosition: SnackPosition.TOP,
      );
      await GetStorage().remove(MyConfig.ACCESS_TOKEN_KEY);
      Get.offAllNamed(RouterName.login);
      print('Error fetching order details: $e');
      Get.snackbar('Lỗi', 'Không thể lấy chi tiết đơn hàng');
    } finally {
      isLoading(false);
    }
  }

  void searchShoes(String query) {
    if (query.isEmpty) {
      filteredShoes.value = shoes;
    } else {
      filteredShoes.value = shoes
          .where((shoe) =>
              shoe.name!.toLowerCase().contains(query.toLowerCase()) ||
              shoe.brand!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  Future<void> getQuantity(String id, String size) async {
    try {
      isLoading(true);
      remainingQuantity.value =
          await _apiService.getQuantity(id, size, userController.token.value);
    } catch (e) {
      Get.snackbar(
        'Thông báo',
        'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
        snackPosition: SnackPosition.TOP,
      );
      await GetStorage().remove(MyConfig.ACCESS_TOKEN_KEY);
      Get.offAllNamed(RouterName.login);
      print('Error fetching quantity: $e');
      // Get.snackbar('Lỗi', 'Không thể lấy số lượng còn lại');
    } finally {
      isLoading(false);
    }
  }
  // void searchShoes(String query) {
  //   if (query.isEmpty) {
  //     filteredShoes.value = shoes;
  //   } else {
  //     String normalizedQuery = removeDiacritics(query);
  //     filteredShoes.value = shoes
  //         .where((shoe) =>
  //             removeDiacritics(shoe.name ?? '').contains(normalizedQuery) ||
  //             removeDiacritics(shoe.brand ?? '').contains(normalizedQuery))
  //         .toList();
  //   }
  // }
}
