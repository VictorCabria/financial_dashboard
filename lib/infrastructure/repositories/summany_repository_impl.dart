import 'package:financial_dashboard/domain/repositories/summany_repository.dart';
import 'package:financial_dashboard/infrastructure/data_sources/summany_remote_data_source.dart';

import '../../domain/entities/transactions.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../data_sources/transaction_remote_data_source.dart';
import '../models/summary_model.dart';

class SummanyRepositoryImpl implements SummanyRepository {
  final SummanyRemoteDataSource remoteDataSource;

  SummanyRepositoryImpl(this.remoteDataSource);

  @override
   Future<SummaryModel> fetchsummany() async {
    return await remoteDataSource.fetchSummary();
  }
}
