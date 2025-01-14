import 'package:get/get.dart';
import 'package:shop_shose/views/cart_screen.dart';
import 'package:shop_shose/views/done_cash_screen.dart';
import 'package:shop_shose/views/home_screen.dart';
import 'package:shop_shose/views/login_screen.dart';
import 'package:shop_shose/views/oder_detail_screen.dart';
import 'package:shop_shose/views/oder_history_screen.dart';
import 'package:shop_shose/views/payment_info.dart';
import 'package:shop_shose/views/payment_screen.dart';
import 'package:shop_shose/views/pin_input.dart';
import 'package:shop_shose/views/signin_screen.dart';
import 'package:shop_shose/views/splash_screen.dart';
import 'package:shop_shose/views/user_info_screen.dart';
import 'package:shop_shose/widget/add_cart_shoe_detail.dart';
import 'router_name.dart';

class Pages {
  static List<GetPage> pages() {
    return [
      GetPage(
        name: RouterName.splash,
        page: () => SplashScreen(),
      ),
      GetPage(
        name: RouterName.login,
        page: () => LoginScreen(),
      ),
      GetPage(
        name: RouterName.signin,
        page: () => SigninScreen(),
      ),
      GetPage(
        name: RouterName.home,
        page: () => HomeScreen(),
      ),
      GetPage(
        name: RouterName.cart,
        page: () => CartScreen(),
      ),
      GetPage(name: RouterName.placement, page: () => PaymentInfoScreen()),
      GetPage(name: RouterName.payment, page: () => PaymentScreen()),
      GetPage(
        name: RouterName.getalloder,
        page: () => OrderHistoryScreen(),
      ),
      GetPage(
        name: RouterName.getdetailoder,
        page: () => OderDetailScreen(),
      ),
      GetPage(
        name: RouterName.donecash,
        page: () => OrderSuccessScreen(),
      ),
      GetPage(
        name: RouterName.addcart,
        page: () => AddCartShoeDetail(shoe: Get.arguments),
      ),
      GetPage(
        name: RouterName.userinfo,
        page: () => UserInfoScreen(),
      ),
      GetPage(
        name: RouterName.pininput,
        page: () => OtpScreen(),
      ),
    ];
  }
}
