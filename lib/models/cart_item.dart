class CartItemData {
  CartItemData({
    required this.data,
  });

  final List<CartItem> data;

  factory CartItemData.fromJson(Map<String, dynamic> json) {
    return CartItemData(
      data: json["data"] == null
          ? []
          : List<CartItem>.from(json["data"]!.map((x) => CartItem.fromJson(x))),
    );
  }
}

class CartItem {
  final int price;
  final String image;
  final int size;
  final int quantity;
  final String name;
  final int idProduct;
  CartItem(
      {required this.price,
      required this.image,
      required this.size,
      required this.quantity,
      required this.name,
      required this.idProduct});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
        price: json['price'],
        image: json['image'],
        size: json['size'],
        quantity: json['quantity'],
        name: json['name'],
        idProduct: json['id_product']);
  }
}
