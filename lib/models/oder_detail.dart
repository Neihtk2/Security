class OderDetail {
  OderDetail({
    required this.name,
    required this.image,
    required this.size,
    required this.quantity,
  });

  final String name;
  final String image;
  final int size;
  final int quantity;

  factory OderDetail.fromJson(Map<String, dynamic> json) {
    return OderDetail(
      name: json["name"],
      image: json["image"],
      size: json["size"],
      quantity: json["quantity"],
    );
  }
}
