import 'package:flutter/material.dart';
import '../models/ledger.dart';
import 'package:intl/intl.dart';

class LedgerList extends StatelessWidget {
  final List<Ledger> ledgers;
  final bool isLoading;
  final String? error;
  final VoidCallback? onRefresh;

  const LedgerList({
    super.key,
    required this.ledgers,
    this.isLoading = false,
    this.error,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Error: $error', style: const TextStyle(color: Colors.red)),
            if (onRefresh != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(onPressed: onRefresh, child: const Text('Retry')),
            ]
          ],
        ),
      );
    }
    if (ledgers.isEmpty) {
      return const Center(child: Text('No ledgers found.'));
    }

    final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');

    return RefreshIndicator(
      onRefresh: () async => onRefresh?.call(),
      child: ListView.separated(
        itemCount: ledgers.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final ledger = ledgers[index];
          final color = ledger.closingBalance < 0 ? Colors.red : Colors.green;
          final balanceType = ledger.closingBalance < 0 ? 'Dr' : 'Cr';

          return ListTile(
            leading: CircleAvatar(
              child: Text(ledger.name.isNotEmpty ? ledger.name[0] : '?'),
            ),
            title: Text(ledger.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(ledger.parent),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${currencyFormat.format(ledger.closingBalance.abs())} $balanceType',
                  style: TextStyle(color: color, fontWeight: FontWeight.w600),
                ),
                Text(ledger.currency,
                    style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          );
        },
      ),
    );
  }
}
