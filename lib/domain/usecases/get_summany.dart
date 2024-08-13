import 'package:financial_dashboard/domain/repositories/summany_repository.dart';

import '../../infrastructure/models/summary_model.dart';
import '../entities/transactions.dart';
import '../repositories/transaction_repository.dart';

class GetSummany {
  final SummanyRepository repository;

  GetSummany(this.repository);

   Future<SummaryModel> call() async {
    return await repository.fetchsummany();
  }
}
