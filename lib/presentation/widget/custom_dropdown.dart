import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../providers/financial_provider.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final financialProvider = Provider.of<FinancialProvider>(context);

    return Row(
      children: [
        Expanded(
          flex: screenSize.width > 600 ? 2 : 1,
          child: DropdownButton<String>(
            value: financialProvider.filterType,
            items: const [
              DropdownMenuItem(
                value: 'all',
                child: Text(
                  'All',
                  style: TextStyle(
                      color: Colors.white), // Estilo para el texto del item
                ),
              ),
              DropdownMenuItem(
                value: 'income',
                child: Text(
                  'Income',
                  style: TextStyle(
                      color: Colors.white), // Estilo para el texto del item
                ),
              ),
              DropdownMenuItem(
                value: 'expense',
                child: Text(
                  'Expense',
                  style: TextStyle(
                      color: Colors.white), // Estilo para el texto del item
                ),
              ),
            ],
            onChanged: (value) {
              financialProvider.updateFilterType(value!);
            },
            dropdownColor:
                Colors.black, // Opcional: color de fondo del dropdown
            style: TextStyle(
                color: Colors.white), // Estilo para el texto del DropdownButton
          ),
        ),
        SizedBox(width: screenSize.width > 600 ? 16.0 : 8.0),
        ElevatedButton(
          onPressed: () async {
            DateTime? selectedMonth = await showMonthPicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );

            if (selectedMonth != null) {
              financialProvider.updateDateRange(DateTimeRange(
                start: DateTime(selectedMonth.year, selectedMonth.month, 1),
                end: DateTime(selectedMonth.year, selectedMonth.month + 1, 0),
              ));
            }
          },
          child: const Text('Select Month'),
        ),
        SizedBox(width: screenSize.width > 600 ? 16.0 : 8.0),
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            financialProvider.resetFilters();
          },
        ),
      ],
    );
  }
}
