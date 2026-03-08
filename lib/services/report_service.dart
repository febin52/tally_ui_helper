import '../core/tally_client.dart';

class ReportService {
  final TallyClient client;

  ReportService(this.client);

  /// Get high-level summary for Dashboard
  Future<Map<String, double>> getDashboardSummary() async {
    // In a real implementation this might call specific reports
    // For now we simulate an aggregate dashboard
    return {
      'totalSales': 0.0,
      'totalReceipts': 0.0,
      'cashBalance': 0.0,
      'bankBalance': 0.0,
    };
  }
}
