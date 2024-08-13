import '../../domain/entities/transactions.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../data_sources/transaction_remote_data_source.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Transaction>> fetchTransactions() async {
    return await remoteDataSource.fetchTransactionsFromApi();
  }
}
