
import '../entities/transactions.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> fetchTransactions();
}
