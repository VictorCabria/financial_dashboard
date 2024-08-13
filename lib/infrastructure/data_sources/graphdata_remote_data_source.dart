import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/graphdata_model.dart';
import '../models/summary_model.dart';
import '../models/transaction_model.dart';

abstract class GraphDataRemoteDataSource {
  Future<GraphDataModel> fetchgraphdata();
}

class GraphDataRemoteDataSourceImpl implements GraphDataRemoteDataSource {
  final String apiUrl = 'http://localhost:3000/transactions/prueba/graphdata';

  @override
  Future<GraphDataModel> fetchgraphdata() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return GraphDataModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load graph data');
    }
  }
}
