import '../../domain/entities/transactions.dart';

class TransactionModel extends Transaction {
  TransactionModel({
    required int id,
    required String? date,
    required String? type,
    required String? amount,
    required String? description,
  }) : super(
            id: id, date: date, type: type, amount: amount, description: description);

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      date: json['date'],
      type: json['type'],
      amount: json['amount'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'type': type,
      'amount': amount,
      'description': description,
    };
  }
}
