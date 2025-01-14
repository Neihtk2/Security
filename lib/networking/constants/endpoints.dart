class Endpoints {
  Endpoints._();

  // authen
  static const String login = "/post-to-login";
  static const String signin = "/post-user";
  static const String getshoes = "/get-shoes";
  static const String getcart = "/get-cart?token=";
  static const String getdetailoder = "/get-detail-order?id_order=";
  static const String getalloder = "/get-all-order?id_user=";
  static const String addcart = "/post-product-to-cart";
  static const String remotefromCart = "/delete-product-in-cart";
  static const String placeOrder = "/post-order";
  static const String payment = "/payment?amount=";
  static const String getquantity = "/get-quantity";
  static const String getUserInfo = "/get-user?token=";
  static const String getOtp = "/verify-otp";
  // static const String refreshToken = "/accounts/refreshToken";
  // static const String api_keys_extend = "/api/api-keys-extend";

  // // user
  // static const String user_info = "/api/api-keys-extend/information";
  // static const String welcomes_extend = "/api/welcomes-extend";
  // static const String channel_pack_masters_extend = "/api/channel-pack-masters-extend/all";

  // static const String menu_service_extend = "/api/menu-services-extend";
  // static const String service_hotels_extend = "/api/service-hotels-extend";

  // static const String intro_hotels_extend = "/api/intro-hotels-extend/oneIntroHotel";
  // static const String language = "$api_keys_extend/language";

  // static const String notification_api_keys = "/api/notification-api-keys-extend";
}
