import 'package:flutter/material.dart';

class FinancialCard extends StatelessWidget {
  final String title;
  final double amount;
  final Color amountColor;
  final double? width; // Parámetro opcional para ajustar el ancho

  const FinancialCard({
    super.key,
    required this.title,
    required this.amount,
    required this.amountColor,
    this.width, // Inicializamos el parámetro
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     width: width,
      constraints:
          const BoxConstraints(minWidth: 150), // Tamaño mínimo para la tarjeta
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
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 10.0),
          Text(
            '\$$amount',
            style: TextStyle(
              color: amountColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
