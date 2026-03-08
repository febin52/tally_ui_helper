import 'package:flutter/material.dart';
import 'package:flutter_tally_erp/flutter_tally_erp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Initialize the ERP instance pointing to your Tally ERP 9 / Prime IP address
    // Make sure Tally is configured to run as an ODBC server on port 9000
    final tallyERP = TallyERP(
      host: 'http://192.168.1.100:9000', // Replace with your Tally Server IP
      enableSync: true, // Automatically fetches background data
      syncInterval: const Duration(minutes: 5),
    );

    // 2. Generate and return the ERP Application
    // This provides a full bottom-navigation based Dashboard, Sales, Inventory, and Ledger UI!
    return tallyERP.generateApp(
      title: 'My Company ERP',
      theme: ThemeData(
        colorSchemeSeed: Colors.blueAccent,
        useMaterial3: true,
      ),
    );
  }
}
