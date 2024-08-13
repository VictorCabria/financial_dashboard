import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/financial_provider.dart';

class TransactionListWidget extends StatelessWidget {
  const TransactionListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FinancialProvider>(
      builder: (context, provider, child) {
        if (provider.transactions.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Expanded(
          child: ListView.builder(
            itemCount: provider.filteredTransactionsByType.length,
            itemBuilder: (context, index) {
              final transaction = provider.filteredTransactionsByType[index];
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, ),
                decoration: BoxDecoration(
                  color: Colors.grey[800], // Fondo gris oscuro para el ListTile
                  borderRadius:
                      BorderRadius.circular(8.0), // Bordes redondeados
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  title: Text(
                    transaction.description ?? 'Unknown Category',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    transaction.date?.toString() ?? 'No Date',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: Text(
                    transaction.amount.toString(),
                    style: TextStyle(
                      color: transaction.type == 'expense'
                          ? Colors.redAccent
                          : Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
