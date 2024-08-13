import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/transaction_model.dart';

abstract class TransactionRemoteDataSource {
  Future<List<TransactionModel>> fetchTransactionsFromApi();
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final String apiUrl = 'http://localhost:3000/transactions';

  @override
  Future<List<TransactionModel>> fetchTransactionsFromApi() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => TransactionModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }
}
