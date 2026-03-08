import 'package:flutter/material.dart';
import '../../core/tally_client.dart';
import '../../models/ledger.dart';
import '../../services/ledger_service.dart';
import '../../widgets/ledger_list.dart';

class LedgerModule extends StatefulWidget {
  final TallyClient client;

  const LedgerModule({super.key, required this.client});

  @override
  State<LedgerModule> createState() => _LedgerModuleState();
}

class _LedgerModuleState extends State<LedgerModule> {
  late LedgerService _ledgerService;
  List<Ledger>? _ledgers;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _ledgerService = LedgerService(widget.client);
    _loadLedgers();
  }

  Future<void> _loadLedgers() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final ledgers = await _ledgerService.getLedgers();
      setState(() => _ledgers = ledgers);
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
        title: const Text('Chart of Accounts'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadLedgers),
        ],
      ),
      body: LedgerList(
        ledgers: _ledgers ?? [],
        isLoading: _isLoading,
        error: _error,
        onRefresh: _loadLedgers,
      ),
    );
  }
}
