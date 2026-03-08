import 'package:flutter/material.dart';
import '../core/tally_client.dart';
import '../services/tally_sync_engine.dart';
import 'modules/dashboard_module.dart';
import 'modules/inventory_module.dart';
import 'modules/ledger_module.dart';
import 'modules/sales_module.dart';

class TallyERP {
  final TallyClient client;
  final TallySyncEngine? syncEngine;

  TallyERP({
    required String host,
    Duration syncInterval = const Duration(minutes: 5),
    bool enableSync = true,
  })  : client = TallyClient(host: host),
        syncEngine = enableSync
            ? TallySyncEngine(
                client: TallyClient(host: host), interval: syncInterval)
            : null {
    if (enableSync) {
      syncEngine?.start();
    }
  }

  /// Generates the full ERP Flutter Application
  Widget generateApp({String title = 'Tally Mobile ERP', ThemeData? theme}) {
    return MaterialApp(
      title: title,
      theme: theme ??
          ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
          ),
      home: ERPRootNavigation(client: client),
    );
  }
}

class ERPRootNavigation extends StatefulWidget {
  final TallyClient client;

  const ERPRootNavigation({super.key, required this.client});

  @override
  State<ERPRootNavigation> createState() => _ERPRootNavigationState();
}

class _ERPRootNavigationState extends State<ERPRootNavigation> {
  int _currentIndex = 0;
  late List<Widget> _modules;

  @override
  void initState() {
    super.initState();
    _modules = [
      DashboardModule(client: widget.client),
      SalesModule(client: widget.client),
      InventoryModule(client: widget.client),
      LedgerModule(client: widget.client),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _modules[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.dashboard), label: 'Dashboard'),
          NavigationDestination(
              icon: Icon(Icons.point_of_sale), label: 'Sales'),
          NavigationDestination(
              icon: Icon(Icons.inventory), label: 'Inventory'),
          NavigationDestination(icon: Icon(Icons.people), label: 'Ledgers'),
        ],
      ),
    );
  }
}
