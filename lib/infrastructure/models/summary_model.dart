import '../../domain/entities/summary.dart';

class SummaryModel extends Summary {
  SummaryModel({
    required double totalBalance,
    required double totalIncome,
    required double totalExpense,
  }) : super(
            totalBalance: totalBalance,
            totalExpense: totalExpense,
            totalIncome: totalIncome);

  factory SummaryModel.fromJson(Map<String, dynamic> json) {
    return SummaryModel(
        totalBalance: json['totalBalance'],
        totalExpense: json['totalExpense'],
        totalIncome: json['totalIncome']);
  }

  Map<String, dynamic> toJson() {
    return {
      'totalBalance': totalBalance,
      'totalExpense': totalExpense,
      'totalIncome': totalIncome,
    };
  }
}
