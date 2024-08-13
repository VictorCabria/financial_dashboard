import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/summary_model.dart';
import '../models/transaction_model.dart';

abstract class SummanyRemoteDataSource {
   Future<SummaryModel> fetchSummary();
}

class SymmanyRemoteDataSourceImpl implements SummanyRemoteDataSource {
  final String apiUrl = 'http://localhost:3000/transactions/prueba/summary';

  @override
  Future<SummaryModel> fetchSummary() async {
    final response =
        await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return SummaryModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load summary');
    }
  }
}
