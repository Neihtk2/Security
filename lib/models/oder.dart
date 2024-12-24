class Order {
  final int idUser;
  final String orderDate;
  final String address;
  final String phoneNumber;
  final int totalPrice;
  final String payment;
  final String status;
  final List<OrderProduct> products;

  Order({
    required this.idUser,
    required this.orderDate,
    required this.address,
    required this.phoneNumber,
    required this.totalPrice,
    required this.payment,
    required this.status,
    required this.products,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      // id: json['id'],
      idUser: json['id_user'],
      orderDate: json['order_date'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      totalPrice: json['total_price'].toDouble(),
      payment: json['payment'],
      status: json['status'],
      products: (json['products'] as List)
          .map((product) => OrderProduct.fromJson(product))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_user': idUser,
      'order_date': orderDate,
      'address': address,
      'phoneNumber': phoneNumber,
      'totalPrice': totalPrice,
      'payment': payment,
      'status': status,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}

class OrderProduct {
  final int idProduct;
  final int size;
  final int quantity;

  OrderProduct({
    required this.idProduct,
    required this.size,
    required this.quantity,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      idProduct: json['id_product'],
      size: json['size'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_product': idProduct,
      'size': size,
      'quantity': quantity,
    };
  }
}
