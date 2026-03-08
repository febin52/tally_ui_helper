import '../core/tally_client.dart';
import '../models/ledger.dart';

class LedgerService {
  final TallyClient client;

  LedgerService(this.client);

  /// Get all ledgers from Tally
  Future<List<Ledger>> getLedgers() async {
    final data = await client.fetchCollection(
      collectionName: 'Ledger',
      fetchList: [
        'GUID',
        'NAME',
        'PARENT',
        'CLOSINGBALANCE',
        'CURRENCYNAME',
        'ADDRESS',
        'PARTYGSTIN',
        'INCOMETAXNUMBER',
        'EMAIL'
      ],
    );

    return data.map((json) => Ledger.fromXmlMap(json)).toList();
  }

  /// Get ledgers filtered by a parent group (e.g., Sundry Debtors)
  Future<List<Ledger>> getLedgersByGroup(String groupName) async {
    final ledgers = await getLedgers();
    return ledgers
        .where((l) => l.parent.toLowerCase() == groupName.toLowerCase())
        .toList();
  }
}
