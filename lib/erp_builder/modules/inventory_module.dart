import 'package:flutter/material.dart';
import '../../core/tally_client.dart';
import '../../models/stock_item.dart';
import '../../services/inventory_service.dart';
import '../../widgets/stock_table.dart';

class InventoryModule extends StatefulWidget {
  final TallyClient client;

  const InventoryModule({super.key, required this.client});

  @override
  State<InventoryModule> createState() => _InventoryModuleState();
}

class _InventoryModuleState extends State<InventoryModule> {
  late InventoryService _inventoryService;
  List<StockItem>? _items;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _inventoryService = InventoryService(widget.client);
    _loadInventory();
  }

  Future<void> _loadInventory() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final items = await _inventoryService.getStockItems();
      setState(() => _items = items);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Master'),
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh), onPressed: _loadInventory),
        ],
      ),
      body: _error != null
          ? Center(child: Text('Error: $_error'))
          : _items == null && !_isLoading
              ? const Center(child: Text('No Stock Items found'))
              : StockTable(
                  items: _items ?? [],
                  isLoading: _isLoading,
                ),
    );
  }
}
