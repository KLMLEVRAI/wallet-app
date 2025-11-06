class Wallet {
  final String address;
  final String privateKey;
  final String publicKey;

  Wallet({
    required this.address,
    required this.privateKey,
    required this.publicKey,
  });

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'privateKey': privateKey,
      'publicKey': publicKey,
    };
  }

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      address: json['address'],
      privateKey: json['privateKey'],
      publicKey: json['publicKey'],
    );
  }
}