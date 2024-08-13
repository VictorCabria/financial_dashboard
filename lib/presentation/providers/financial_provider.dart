import 'package:flutter/material.dart';
import '../../domain/entities/graphdata.dart';
import '../../domain/entities/transactions.dart';
import '../../domain/usecases/get_graphdata.dart';
import '../../domain/usecases/get_summany.dart';
import '../../domain/usecases/get_transactions.dart';
import '../../infrastructure/models/graphdata_model.dart';
import '../../infrastructure/models/summary_model.dart';

class FinancialProvider with ChangeNotifier {
  final GetTransactions getTransactions;
  final GetSummany getSummary;
  final GetGraData getgradata;
  List<Transaction> _transactions = [];
  SummaryModel? _summary;
  GraphData? _getGraphData;

  bool _showIncome = true;
  String _filterType = 'all'; // Para controlar el filtro de tipo
  DateTime? _selectedMonth; // Para controlar el mes seleccionado
  DateTimeRange? _selectedDateRange;
  String _errorMessage = '';
  double? _totalBalance = 0.0;
  double? _monthlyIncome = 0.0;
  double? _monthlyExpense = 0.0;

  FinancialProvider(
      {required this.getTransactions,
      required this.getSummary,
      required this.getgradata});

  List<Transaction> get transactions => _transactions;
  bool get showIncome => _showIncome;
  double get totalBalance => _totalBalance!;
  double get monthlyIncome => _monthlyIncome!;
  double get monthlyExpense => _monthlyExpense!;
  String get filterType => _filterType;
  SummaryModel? get summary => _summary;
  GraphData? get graphData => _getGraphData;

  Future<void> loadTransactions() async {
    try {
      _transactions = await getTransactions();
      await fetchSummary();
      await fetchGraphData(); // Actualiza el gráfico con datos filtrados
      notifyListeners();
      _errorMessage = ''; // Clear any previous errors
    } catch (e) {
      _errorMessage = 'Failed to load transactions: $e';
    } finally {
      notifyListeners();
    }
  }

  void updateFilterType(String type) {
    _filterType = type;
    fetchGraphData(); // Recalcula los datos del gráfico según el filtro
    notifyListeners();
  }

  void updateDateRange(DateTimeRange dateRange) {
    _selectedDateRange = dateRange;
    fetchGraphData(); // Recalcula los datos del gráfico según el rango de fechas
    notifyListeners();
  }

  void resetFilters() {
    _filterType = 'all'; // Restablecer el filtro de tipo
    _selectedDateRange = null; // Restablecer el rango de fechas
    fetchGraphData(); // Recalcula los datos del gráfico al restablecer los filtros
    notifyListeners();
  }

  Future<void> fetchSummary() async {
    try {
      _summary = await getSummary();
      _totalBalance = _summary!.totalBalance;
      _monthlyIncome = _summary!.totalIncome;
      _monthlyExpense = _summary!.totalExpense;
      notifyListeners();
    } catch (e) {
      // Manejar error
    }
  }

Future<void> fetchGraphData() async {
    try {
      List<Transaction> filteredTransactions = filteredTransactionsByType;

      // Recalcular los datos del gráfico usando las transacciones filtradas
      List<double> incomeData = List.filled(12, 0.0);
      List<double> expenseData = List.filled(12, 0.0);

      for (var transaction in filteredTransactions) {
        int month = _parseDate(transaction.date!).month - 1;
        if (transaction.type == 'income') {
          incomeData[month] += _parseAmount(transaction.amount!);
        } else if (transaction.type == 'expense') {
          expenseData[month] += _parseAmount(transaction.amount!);
        }
      }

      _getGraphData =
          GraphData(incomeData: incomeData, expenseData: expenseData);
      notifyListeners();
    } catch (e) {
      // Manejar error
    }
  }
  // Método para alternar el tipo de gráfico (ingresos/gastos)
  void toggleChartType() {
    _showIncome = !_showIncome;
    notifyListeners();
  }

  // Método para agregar una nueva transacción
  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    fetchGraphData(); // Recalcula los datos del gráfico al agregar una transacción
    notifyListeners();
  }

  // Cálculo de ingresos totales
  double get totalIncome => _transactions
      .where((t) => t.type == 'income')
      .fold(0.0, (sum, t) => sum + _parseAmount(t.amount!));

  double get totalExpense => _transactions
      .where((t) => t.type == 'expense')
      .fold(0.0, (sum, t) => sum + _parseAmount(t.amount!));

  // Método para convertir el String a double
  double _parseAmount(String amount) {
    try {
      return double.parse(amount);
    } catch (e) {
      print('Error parsing amount: $e');
      return 0.0; // Devolver 0.0 si ocurre un error de conversión
    }
  }

  // Cálculo de ingresos mensuales
  DateTime _parseDate(String date) {
    try {
      return DateTime.parse(date);
    } catch (e) {
      print('Error parsing date: $e');
      return DateTime.now(); // O cualquier fecha predeterminada
    }
  }

  List<Transaction> get filteredTransactionsByType {
    List<Transaction> filteredTransactions = _transactions;

    // Filtrar por tipo de transacción
    if (_filterType != 'all') {
      filteredTransactions = filteredTransactions.where((transaction) {
        return transaction.type == _filterType;
      }).toList();
    }

    // Filtrar por rango de fechas
    if (_selectedDateRange != null) {
      filteredTransactions = filteredTransactions.where((transaction) {
        DateTime transactionDate = _parseDate(transaction.date!);
        return transactionDate.isAfter(_selectedDateRange!.start) &&
            transactionDate
                .isBefore(_selectedDateRange!.end.add(Duration(days: 1)));
      }).toList();
    }

    return filteredTransactions;
  }
}
