class OderRequest {
  OderRequest({
    required this.data,
  });

  final List<Datum> data;

  factory OderRequest.fromJson(Map<String, dynamic> json) {
    return OderRequest(
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  Datum({
    required this.id,
    required this.idUser,
    required this.orderDate,
    required this.address,
    required this.phoneNumber,
    required this.totalPrice,
    required this.payment,
    required this.status,
  });

  final int id;
  final int idUser;
  final String orderDate;
  final String address;
  final String phoneNumber;
  final int totalPrice;
  final String payment;
  final String status;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"],
      idUser: json["id_user"],
      orderDate: json["order_date"],
      address: json["address"],
      phoneNumber: json["phone_number"],
      totalPrice: json["total_price"],
      payment: json["payment"],
      status: json["status"],
    );
  }
}
