import 'package:financial_dashboard/domain/repositories/summany_repository.dart';

import '../../infrastructure/models/graphdata_model.dart';
import '../../infrastructure/models/summary_model.dart';
import '../entities/transactions.dart';
import '../repositories/graphdata_repository.dart';
import '../repositories/transaction_repository.dart';

class GetGraData {
  final GraphDataRepository repository;

  GetGraData(this.repository);

   Future<GraphDataModel> call() async {
    return await repository.fetchgraphdata();
  }
}
