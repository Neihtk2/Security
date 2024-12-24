class PaymentInfo {
  final String address;
  final String phoneNumber;

  PaymentInfo({required this.address, required this.phoneNumber});

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'phoneNumber': phoneNumber,
    };
  }
}
