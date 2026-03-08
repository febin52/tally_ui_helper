import 'package:flutter/material.dart';

class ERPDashboard extends StatelessWidget {
  final Map<String, double> summary;

  const ERPDashboard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;

      return GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
        children: [
          _buildMetricCard(
              context, 'Total Sales', summary['totalSales'] ?? 0, Colors.blue),
          _buildMetricCard(context, 'Total Receipts',
              summary['totalReceipts'] ?? 0, Colors.green),
          _buildMetricCard(context, 'Cash Balance', summary['cashBalance'] ?? 0,
              Colors.orange),
          _buildMetricCard(context, 'Bank Balance', summary['bankBalance'] ?? 0,
              Colors.purple),
        ],
      );
    });
  }

  Widget _buildMetricCard(
      BuildContext context, String title, double value, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [color.withValues(alpha: 0.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            FittedBox(
              child: Text(
                '₹${value.toStringAsFixed(2)}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
