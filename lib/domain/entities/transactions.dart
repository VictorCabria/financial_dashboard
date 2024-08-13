// domain/entities/transaction.dart
class Transaction {
  final int id;
  final String? date;
  final String? type; // 'income' o 'expense'
  final String? amount;
  final String? description;

  Transaction({
    required this.id,
    required this.date,
    required this.type,
    required this.amount,
    required this.description,
  });
}
