import '../../domain/entities/graphdata.dart';
import '../../domain/entities/transactions.dart';

class GraphDataModel extends GraphData {
  GraphDataModel({
    required List<double> incomeData,
    required List<double> expenseData,
  }) : super(incomeData: incomeData, expenseData: expenseData);

  factory GraphDataModel.fromJson(Map<String, dynamic> json) {
    return GraphDataModel(
      incomeData:
          List<double>.from(json['incomeData'].map((x) => x.toDouble())),
      expenseData:
          List<double>.from(json['expenseData'].map((x) => x.toDouble())),
    );
  }
}
