import 'package:flutter/material.dart';
import '../../core/tally_client.dart';
import '../../services/report_service.dart';
import '../../widgets/erp_dashboard.dart';

class DashboardModule extends StatefulWidget {
  final TallyClient client;

  const DashboardModule({super.key, required this.client});

  @override
  State<DashboardModule> createState() => _DashboardModuleState();
}

class _DashboardModuleState extends State<DashboardModule> {
  late ReportService _reportService;
  Map<String, double>? _summary;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _reportService = ReportService(widget.client);
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final summary = await _reportService.getDashboardSummary();
      setState(() {
        _summary = summary;
      });
    } catch (e) {
      debugPrint('Error loading dashboard: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ERP Dashboard'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadData),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _summary != null
              ? ERPDashboard(summary: _summary!)
              : const Center(child: Text('Failed to load dashboard data')),
    );
  }
}
