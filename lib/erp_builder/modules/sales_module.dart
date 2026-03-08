import 'package:flutter/material.dart';
import '../../core/tally_client.dart';
import '../../models/voucher.dart';
import '../../services/voucher_service.dart';
import '../../widgets/voucher_view.dart';

class SalesModule extends StatefulWidget {
  final TallyClient client;

  const SalesModule({super.key, required this.client});

  @override
  State<SalesModule> createState() => _SalesModuleState();
}

class _SalesModuleState extends State<SalesModule> {
  late VoucherService _voucherService;
  List<Voucher>? _vouchers;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _voucherService = VoucherService(widget.client);
    _loadVouchers();
  }

  Future<void> _loadVouchers() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final vouchers = await _voucherService.getVouchersByType('Sales');
      setState(() => _vouchers = vouchers);
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
        title: const Text('Sales Vouchers'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadVouchers),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : _vouchers == null || _vouchers!.isEmpty
                  ? const Center(child: Text('No Sales records found'))
                  : ListView.builder(
                      itemCount: _vouchers!.length,
                      itemBuilder: (context, index) {
                        return VoucherViewer(voucher: _vouchers![index]);
                      },
                    ),
    );
  }
}
