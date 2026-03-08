import 'package:flutter/material.dart';
import '../models/stock_item.dart';
import 'package:intl/intl.dart';

class StockTable extends StatelessWidget {
  final List<StockItem> items;
  final bool isLoading;

  const StockTable({
    super.key,
    required this.items,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');

    // Make the table scrollable horizontally to prevent overflow
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Item Name')),
          DataColumn(label: Text('Group')),
          DataColumn(label: Text('Stock (Units)')),
          DataColumn(label: Text('Closing Value')),
        ],
        rows: items.map((item) {
          return DataRow(cells: [
            DataCell(Text(item.name,
                style: const TextStyle(fontWeight: FontWeight.bold))),
            DataCell(Text(item.parent)),
            DataCell(Text(
                '${item.closingBalance.toStringAsFixed(2)} ${item.baseUnits}')),
            DataCell(Text(currencyFormat.format(item.closingValue))),
          ]);
        }).toList(),
      ),
    );
  }
}
