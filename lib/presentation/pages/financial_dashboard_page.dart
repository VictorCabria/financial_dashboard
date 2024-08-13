import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/financial_provider.dart';
import '../widget/chart.dart';
import '../widget/custom_dropdown.dart';
import '../widget/financial_card.dart';
import '../widget/transaction_list.dart';

class FinancialDashboardPage extends StatelessWidget {
  const FinancialDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final financialProvider = Provider.of<FinancialProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return constraints.maxWidth > 600
                ? _buildLargeScreenLayout(
                    financialProvider, constraints.maxWidth)
                : SingleChildScrollView(
                    child: _buildSmallScreenLayout(
                        financialProvider, constraints.maxWidth),
                  );
          },
        ),
      ),
    );
  }

  Widget _buildLargeScreenLayout(
      FinancialProvider financialProvider, double maxWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FinancialCard(
              title: 'This Month\'s Income',
              amount: financialProvider.totalBalance,
              amountColor: Colors.greenAccent,
              width: maxWidth * 0.25, // Ajuste de ancho en pantalla grande
            ),
            const SizedBox(height: 10.0),
            FinancialCard(
              title: 'Total Income',
              amount: financialProvider.totalIncome,
              amountColor: Colors.greenAccent,
              width: maxWidth * 0.25, // Ajuste de ancho en pantalla grande
            ),
            const SizedBox(height: 10.0),
            FinancialCard(
              title: 'Total Losses',
              amount: financialProvider.totalExpense,
              amountColor: Colors.redAccent,
              width: maxWidth * 0.25, // Ajuste de ancho en pantalla grande
            ),
          ],
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0, 5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Financial Overview',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      height: 200,
                      child: FinancialChart(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0, 5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Recent Transactions',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        const SizedBox(height: 16.0),
                        CustomDropdown(),
                        Expanded(
                          child: TransactionListWidget(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSmallScreenLayout(
      FinancialProvider financialProvider, double maxWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            FinancialCard(
              title: 'This Month\'s Income',
              amount: financialProvider.totalBalance,
              amountColor: Colors.greenAccent,
              width: maxWidth / 2 - 20,
            ),
            FinancialCard(
              title: 'Total Income',
              amount: financialProvider.totalIncome,
              amountColor: Colors.greenAccent,
              width: maxWidth / 2 - 20,
            ),
            FinancialCard(
              title: 'Total Losses',
              amount: financialProvider.totalExpense,
              amountColor: Colors.redAccent,
              width: maxWidth / 2 - 20,
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          width: maxWidth,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(0, 5),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Financial Overview',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 200,
                child: FinancialChart(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          width: maxWidth,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(0, 5),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Recent Transactions',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 16.0),
              CustomDropdown(),
              const SizedBox(height: 16.0),
              SizedBox(
                height:
                    200, // Ajuste de altura para que se vea bien en pantalla pequeña
                child: TransactionListWidget(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
