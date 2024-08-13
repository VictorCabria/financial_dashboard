import 'package:financial_dashboard/domain/usecases/get_graphdata.dart';
import 'package:financial_dashboard/domain/usecases/get_summany.dart';
import 'package:financial_dashboard/infrastructure/data_sources/graphdata_remote_data_source.dart';
import 'package:financial_dashboard/infrastructure/data_sources/summany_remote_data_source.dart';
import 'package:financial_dashboard/infrastructure/repositories/graphdata_repository_impl.dart';
import 'package:financial_dashboard/infrastructure/repositories/summany_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'domain/usecases/get_transactions.dart';
import 'infrastructure/data_sources/transaction_remote_data_source.dart';
import 'infrastructure/repositories/transaction_repository_impl.dart';
import 'presentation/pages/financial_dashboard_page.dart';
import 'presentation/providers/financial_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            final financialProvider = FinancialProvider(
              getTransactions: GetTransactions(
                TransactionRepositoryImpl(
                  TransactionRemoteDataSourceImpl(),
                ),
              ),
              getSummary: GetSummany(
                SummanyRepositoryImpl(
                  SymmanyRemoteDataSourceImpl(),
                ),
              ),
              getgradata: GetGraData(
                GraphDataRepositoryImpl(
                  GraphDataRemoteDataSourceImpl(),
                ),
              ),
            );
            financialProvider
                .loadTransactions(); // Cargar las transacciones al inicio
            return financialProvider;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Financial Dashboard',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false, // Desactiva el banner de debug
        home: FinancialDashboardPage(),
      ),
    );
  }
}
