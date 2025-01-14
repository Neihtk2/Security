import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_shose/config/my_config.dart';
import 'package:shop_shose/models/user_model.dart';
import 'package:shop_shose/services/api_service.dart';
import 'package:shop_shose/x_router/router_name.dart';

class AuthViewModel extends GetxController {
  final ApiService _apiService = ApiService();
  RxBool isLoggedIn = false.obs;
  final RxString token = '${GetStorage().read(MyConfig.ACCESS_TOKEN_KEY)}'.obs;
  final RxBool isLoading = false.obs;
  final userinfo = Rxn<User?>(null);
  Future<void> login(String username, String password) async {
    try {
      if (username.isNotEmpty || password.isNotEmpty) {
        final response = await _apiService.LoginApp(username, password);
        if (response.statusCode == 200) {
          // final data = response.data; // Giả sử dữ liệu trả về là JSON
          // userdata.value = UserData.fromJson(data);
          // isLoggedIn.value = true;
          // await GetStorage()
          //     .write(MyConfig.ACCESS_TOKEN_KEY, userdata.value?.token);
          // await GetStorage().write(MyConfig.ID_USER, userdata.value?.data?.id);
          // await GetStorage()
          //     .write(MyConfig.NAME_USER, userdata.value?.data?.name);
          // await getUserInfo(userdata.value?.token ?? '');
          Get.toNamed(RouterName.pininput,
              arguments: username); // Chuyển đến màn hình chính
        } else {
          Get.snackbar('Error', 'Login failed'); // Thông báo lỗi
        }
      }
    } catch (e) {
      Get.snackbar('Error', e.toString()); // Xử lý lỗi
    }
  }

  Future<void> vetifyOtp(String username, String otp) async {
    try {
      if (username.isNotEmpty || otp.isNotEmpty) {
        final response = await _apiService.verifyOtp(username, otp);
        if (response.statusCode == 200) {
          final data = response.data;
          isLoggedIn.value = true;
          token.value = data['data'];
          await GetStorage().write(MyConfig.ACCESS_TOKEN_KEY, data['data']);
          var a = data['data'];
          print("Token ne Nhan oi: " + a);
          // await GetStorage().write(MyConfig.ID_USER, userdata.value?.data?.id);
          // await GetStorage()
          //     .write(MyConfig.NAME_USER, userdata.value?.data?.name);
          // await getUserInfo(userdata.value?.token ?? '');
          Get.offAllNamed(RouterName.splash); // Chuyển đến màn hình chính
        } else {
          Get.snackbar('Error', 'Login failed'); // Thông báo lỗi
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Bạn đã nhập sai mã OTP'); // Xử lý lỗi
    }
  }

  Future<void> Logout() async {
    try {
      await GetStorage().remove(MyConfig.ACCESS_TOKEN_KEY);
      isLoggedIn.value = false;
      userinfo.value = null;
      token.value = '';
      Get.offAllNamed(RouterName.login);
      Get.snackbar('Success', 'Logged out successfully');
    } catch (e) {
      Get.snackbar('Error', 'Logout failed: ${e.toString()}');
    }
  }

  Future<void> signin(String username, String password, String email,
      String phoneNumber) async {
    try {
      final response =
          await _apiService.SigninApp(phoneNumber, password, username, email);
      if (response.statusCode == 200) {
        isLoggedIn.value = true;
        Get.offAllNamed(RouterName.splash); // Chuyển đến màn hình chính
      } else {
        Get.snackbar('Error', 'Login failed'); // Thông báo lỗi
      }
    } catch (e) {
      Get.snackbar('Error', e.toString()); // Xử lý lỗi
    }
  }

  Future<void> getUserInfo() async {
    try {
      isLoading(true);
      userinfo.value = await _apiService.getUserInfo(token.value);
    } catch (e) {
      print('Error fetching user info: $e');
      Get.snackbar('Error', 'Unable to fetch user information');
    } finally {
      isLoading(false);
    }
  }
}
