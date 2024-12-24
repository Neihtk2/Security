import 'package:dio/dio.dart';
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

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: baseURL));
  Future<Response> LoginApp(String phoneNumber, String password) async {
    return await _dio.post(Endpoints.login, data: {
      'phoneNumber': phoneNumber,
      'pass': password,
    });
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

  Future<CartItemData> getCart() async {
    final response = await _dio
        .get(Endpoints.getcart + GetStorage().read(MyConfig.ACCESS_TOKEN_KEY));
    if (response.statusCode == 200) {
      return CartItemData.fromJson(response.data);
    } else {
      throw Exception('Failed to load shoes');
    }
  }

  Future<String> createPayment(int amount) async {
    try {
      final response = await _dio.get(Endpoints.payment + amount.toString());
      return response.data['data']['vnpUrl'];
    } catch (e) {
      throw Exception('Không thể tạo thanh toán: $e');
    }
  }

  Future<void> addToCart(
      String token, String productId, String size, int quantity) async {
    try {
      await _dio.post('/post-product-to-cart', data: {
        'token': token,
        'id_product': productId,
        'size': size,
        'quantity': quantity,
      });
    } catch (e) {
      throw Exception('Không thể thêm sản phẩm vào giỏ hàng: $e');
    }
  }

  Future<void> remotefromCart(int idUser, int idProduct, int size) async {
    try {
      final response = await _dio.delete(
        Endpoints.remotefromCart,
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

  Future<ShoesData> getShoes() async {
    final response = await _dio.get(Endpoints.getshoes);
    if (response.statusCode == 200) {
      return ShoesData.fromJson(response.data);
    } else {
      throw Exception('Failed to load shoes');
    }
  }

  Future<void> postOrder(Order order) async {
    try {
      final response = await _dio.post(
        Endpoints.placeOrder,
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

  Future<List<Datum>> getAllOrders(int userId) async {
    try {
      final response = await _dio.get(Endpoints.getalloder + userId.toString());
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

  Future<List<OderDetail>> getOrderDetails(int orderId) async {
    try {
      final response =
          await _dio.get(Endpoints.getdetailoder + orderId.toString());
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

  Future<int> getQuantity(String id, String size) async {
    try {
      final response =
          await _dio.get('${Endpoints.getquantity}?id=$id&size=$size');
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
        throw Exception('Failed to load quantity');
      }
    } catch (e) {
      throw Exception('Error getting quantity: $e');
    }
  }

  Future<User> getUserInfo(String token) async {
    try {
      final response = await _dio.get('${Endpoints.getUserInfo}$token');
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
