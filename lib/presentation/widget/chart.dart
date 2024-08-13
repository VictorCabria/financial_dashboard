import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/graphdata.dart';
import '../providers/financial_provider.dart';

class FinancialChart extends StatelessWidget {
  const FinancialChart({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Consumer<FinancialProvider>(
      builder: (context, provider, child) {
        final graphData = provider.graphData;

        if (graphData == null) {
          return Center(child: CircularProgressIndicator());
        }

        List<FlSpot> incomeSpots = graphData.incomeData
            .asMap()
            .entries
            .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
            .toList();

        List<FlSpot> expenseSpots = graphData.expenseData
            .asMap()
            .entries
            .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
            .toList();

        return SizedBox(
          height: screenSize.height * 0.3, // Adjust height based on screen size
          child: LineChart(
            LineChartData(
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.white),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: Colors.white.withOpacity(0.1),
                    strokeWidth: 1,
                  );
                },
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.white.withOpacity(0.1),
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      const style =
                          TextStyle(color: Colors.white, fontSize: 12);
                      return Text(_getMonth(value.toInt()), style: style);
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 500,
                    reservedSize: 50,
                    getTitlesWidget: (value, meta) {
                      const style =
                          TextStyle(color: Colors.white, fontSize: 12);
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          value.toInt().toString(),
                          style: style,
                        ),
                      );
                    },
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              minX: 0,
              maxX: 11,
              minY: 0,
              maxY: _calculateMaxY(provider, graphData),
              lineBarsData:
                  _buildLineBarsData(provider, incomeSpots, expenseSpots),
            ),
          ),
        );
      },
    );
  }

  String _getMonth(int monthIndex) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[monthIndex];
  }

  double _calculateMaxY(FinancialProvider provider, GraphData graphData) {
    double maxY = (provider.filterType == 'all'
            ? [...graphData.incomeData, ...graphData.expenseData]
                .reduce((a, b) => a > b ? a : b)
            : provider.filterType == 'income'
                ? graphData.incomeData.reduce((a, b) => a > b ? a : b)
                : graphData.expenseData.reduce((a, b) => a > b ? a : b)) +
        100;
    return maxY;
  }

  List<LineChartBarData> _buildLineBarsData(FinancialProvider provider,
      List<FlSpot> incomeSpots, List<FlSpot> expenseSpots) {
    return [
      if (provider.filterType == 'all' || provider.filterType == 'income')
        LineChartBarData(
          spots: incomeSpots,
          isCurved: true,
          color: Colors.greenAccent,
          belowBarData: BarAreaData(
            show: true,
            color: Colors.greenAccent.withOpacity(0.3),
          ),
        ),
      if (provider.filterType == 'all' || provider.filterType == 'expense')
        LineChartBarData(
          spots: expenseSpots,
          isCurved: true,
          color: Colors.redAccent,
          belowBarData: BarAreaData(
            show: true,
            color: Colors.redAccent.withOpacity(0.3),
          ),
        ),
    ];
  }
}
