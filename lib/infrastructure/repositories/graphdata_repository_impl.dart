import 'package:financial_dashboard/domain/repositories/summany_repository.dart';
import 'package:financial_dashboard/infrastructure/data_sources/graphdata_remote_data_source.dart';
import 'package:financial_dashboard/infrastructure/data_sources/summany_remote_data_source.dart';

import '../../domain/entities/transactions.dart';
import '../../domain/repositories/graphdata_repository.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../data_sources/transaction_remote_data_source.dart';
import '../models/graphdata_model.dart';
import '../models/summary_model.dart';

class GraphDataRepositoryImpl implements GraphDataRepository {
  final GraphDataRemoteDataSource remoteDataSource;

  GraphDataRepositoryImpl(this.remoteDataSource);

  @override
  Future<GraphDataModel> fetchgraphdata() async {
    return await remoteDataSource.fetchgraphdata();
  }
}
