import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:get_storage/get_storage.dart';
import 'package:shop_shose/config/my_config.dart';
import 'package:shop_shose/models/cart_item.dart';
import 'package:shop_shose/models/get_oder.dart';
import 'package:shop_shose/models/oder.dart';
import 'package:shop_shose/models/oder_detail.dart';
import 'package:shop_shose/models/shoes_model.dart';
import 'package:shop_shose/models/user_model.dart';
import 'package:shop_shose/networking/constants/endpoints.dart';
import 'package:shop_shose/services/baseURL.dart';
import 'package:shop_shose/x_router/router_name.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: baseURL));
  // final token = GetStorage().read(MyConfig.ACCESS_TOKEN_KEY);
  Future<Response> LoginApp(String phoneNumber, String password) async {
    return await _dio.post(Endpoints.login, data: {
      'email': phoneNumber,
      'pass': password,
    });
  }

  Future<Response> verifyOtp(String email, String otp) async {
    return await _dio.post(Endpoints.getOtp, data: {
      'email': email,
      'otp': otp,
    });

    //   if (response.statusCode == 200) {
    //     return response.data['token'];
    //   }
    //   return null;
    // } catch (e) {
    //   print('OTP verification error: $e');
    //   return null;
    // }
  }

  Future<Response> SigninApp(
      String phoneNumber, String password, String name, String email) async {
    return await _dio.post(Endpoints.signin, data: {
      'phoneNumber': phoneNumber,
      'pass': password,
      'name': name,
      'email': email
    });
  }

  Future<CartItemData> getCart(String token) async {
    final response = await _dio.get(
      Endpoints.getcart,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token', // Truyền token vào header
        },
      ),
    );
    if (response.statusCode == 200) {
      return CartItemData.fromJson(response.data);
    } else {
      getx.Get.snackbar(
        'Thông báo',
        'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
        snackPosition: getx.SnackPosition.BOTTOM,
      );
      await GetStorage().remove(MyConfig.ACCESS_TOKEN_KEY);
      getx.Get.offAllNamed(RouterName.login);
      throw Exception('Failed to load shoes');
    }
  }

  Future<String> createPayment(int amount, String token) async {
    try {
      final response = await _dio.get(
        Endpoints.payment + amount.toString(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Truyền token vào header
          },
        ),
      );
      return response.data['data']['vnpUrl'];
    } catch (e) {
      throw Exception('Không thể tạo thanh toán: $e');
    }
  }

  Future<void> addToCart(
      String token, String productId, String size, int quantity) async {
    try {
      await _dio.post(Endpoints.addcart,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token', // Truyền token vào header
            },
          ),
          data: {
            'id_product': productId,
            'size': size,
            'quantity': quantity,
          });
    } catch (e) {
      throw Exception('Không thể thêm sản phẩm vào giỏ hàng: $e');
    }
  }

  Future<void> remotefromCart(
      int idUser, int idProduct, int size, String token) async {
    try {
      final response = await _dio.delete(
        Endpoints.remotefromCart,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Truyền token vào header
          },
        ),
        data: {
          'id_user': idUser,
          'id_product': idProduct,
          'size': size,
        },
      );

      if (response.statusCode == 200) {
        print('Đơn hàng đã được xóa thành công');
      } else {
        throw Exception('Lỗi khi xóa đơn hàng: ${response.statusCode}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(
            'Lỗi từ server khi xóa đơn hàng: ${e.response?.statusCode} - ${e.response?.statusMessage}');
      } else {
        throw Exception('Lỗi kết nối khi xóa đơn hàng: ${e.message}');
      }
    } catch (e) {
      throw Exception('Lỗi không xác định khi xóa đơn hàng: $e');
    }
  }

  Future<ShoesData> getShoes(String token) async {
    final response = await _dio.get(
      Endpoints.getshoes,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token', // Truyền token vào header
        },
      ),
    );

    if (response.statusCode == 200) {
      return ShoesData.fromJson(response.data);
    } else {
      throw Exception('Failed to load shoes');
    }
  }

  Future<void> postOrder(Order order, String token) async {
    try {
      final response = await _dio.post(
        Endpoints.placeOrder,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Truyền token vào header
          },
        ),
        data: order.toJson(),
      );
      if (response.statusCode == 200) {
        print('Order placed successfully');
      } else {
        throw Exception('Failed to place order: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error placing order: $e');
    }
  }

  Future<List<Datum>> getAllOrders(int userId, String token) async {
    try {
      final response = await _dio.get(
        Endpoints.getalloder + userId.toString(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Truyền token vào header
          },
        ),
      );
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          List<dynamic> ordersData = response.data['data'];
          return ordersData.map((item) => Datum.fromJson(item)).toList();
        } else {
          throw Exception('Data field is missing in the API response');
        }
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      throw Exception('Error getting orders: $e');
    }
  }

  Future<List<OderDetail>> getOrderDetails(int orderId, String token) async {
    try {
      final response = await _dio.get(
        Endpoints.getdetailoder + orderId.toString(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Truyền token vào header
          },
        ),
      );
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          List<dynamic> ordersData = response.data['data'];
          return ordersData.map((item) => OderDetail.fromJson(item)).toList();
        } else {
          throw Exception('Data field is missing in the API response');
        }
      } else {
        throw Exception('Failed to load order details');
      }
    } catch (e) {
      throw Exception('Error getting order details: $e');
    }
  }

  Future<int> getQuantity(String id, String size, String token) async {
    try {
      final response = await _dio.get(
        '${Endpoints.getquantity}?id=$id&size=$size',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Truyền token vào header
          },
        ),
      );
      if (response.statusCode == 200 && response.data['data'] != null) {
        List<dynamic> data = response.data['data'];
        if (data.isNotEmpty) {
          int quantity = int.tryParse(data[0]['quantity'].toString()) ?? 0;
          return quantity;
        } else {
          print('Data array is empty');
          return 0; // Trả về giá trị mặc định nếu không có dữ liệu
        }
      } else {
        getx.Get.snackbar(
          'Thông báo',
          'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
          snackPosition: getx.SnackPosition.BOTTOM,
        );
        await GetStorage().remove(MyConfig.ACCESS_TOKEN_KEY);
        getx.Get.offAllNamed(RouterName.login);
        throw Exception('Failed to load quantity');
      }
    } catch (e) {
      throw Exception('Error getting quantity: $e');
    }
  }

  Future<User> getUserInfo(String token) async {
    try {
      final response = await _dio.get(
        Endpoints.getUserInfo,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Truyền token vào header
          },
        ),
      );
      if (response.statusCode == 200 && response.data != null) {
        return User.fromJson(response.data['data'][0]);
      } else {
        throw Exception('Failed to load user information');
      }
    } catch (e) {
      throw Exception('Error getting user information: $e');
    }
  }
}
