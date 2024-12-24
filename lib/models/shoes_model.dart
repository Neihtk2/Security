class ShoesData {
  ShoesData({
    required this.data,
  });

  final List<Shoes> data;

  factory ShoesData.fromJson(Map<String, dynamic> json) {
    return ShoesData(
      data: json["data"] == null
          ? []
          : List<Shoes>.from(json["data"]!.map((x) => Shoes.fromJson(x))),
    );
  }
}

class Shoes {
  Shoes({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.discount,
    required this.brand,
    required this.describ,
    required this.sold,
    required this.quantity,
  });

  final int? id;
  final String? name;
  final String? image;
  final int? price;
  final int? discount;
  final String? brand;
  final String? describ;
  final String? sold;
  final String? quantity;

  factory Shoes.fromJson(Map<String, dynamic> json) {
    return Shoes(
      id: json["id"] ?? 0,
      name: json["name"] ?? '',
      image: json["image"] ?? '',
      price: json["price"] ?? '',
      discount: json["discount"] ?? '',
      brand: json["brand"],
      describ: json["describ"],
      sold: json["sold"],
      quantity: json["quantity"],
    );
  }
}
