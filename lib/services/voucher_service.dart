import '../core/tally_client.dart';
import '../models/voucher.dart';

class VoucherService {
  final TallyClient client;

  VoucherService(this.client);

  /// Get all vouchers
  Future<List<Voucher>> getVouchers() async {
    final data = await client.fetchCollection(
      collectionName: 'Voucher',
      fetchList: [
        'GUID',
        'VOUCHERNUMBER',
        'DATE',
        'VOUCHERTYPENAME',
        'PARTYLEDGERNAME',
        'AMOUNT',
        'NARRATION'
      ],
    );

    return data.map((json) => Voucher.fromXmlMap(json)).toList();
  }

  /// Get vouchers by type (e.g., Sales, Purchase, Receipt)
  Future<List<Voucher>> getVouchersByType(String type) async {
    final vouchers = await getVouchers();
    return vouchers
        .where((v) => v.voucherType.toLowerCase() == type.toLowerCase())
        .toList();
  }
}
