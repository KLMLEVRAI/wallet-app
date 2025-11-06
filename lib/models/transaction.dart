enum TransactionType {
  send,
  receive,
}

enum TransactionStatus {
  pending,
  confirmed,
  failed,
}

class Transaction {
  final String id;
  final TransactionType type;
  final double amount;
  final String address;
  final DateTime timestamp;
  final TransactionStatus status;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.address,
    required this.timestamp,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString(),
      'amount': amount,
      'address': address,
      'timestamp': timestamp.toIso8601String(),
      'status': status.toString(),
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      type: TransactionType.values.firstWhere(
        (e) => e.toString() == json['type'],
      ),
      amount: json['amount'],
      address: json['address'],
      timestamp: DateTime.parse(json['timestamp']),
      status: TransactionStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
      ),
    );
  }
}