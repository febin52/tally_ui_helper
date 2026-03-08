import '../core/tally_client.dart';
import '../models/stock_item.dart';

class InventoryService {
  final TallyClient client;

  InventoryService(this.client);

  /// Get all stock items from Tally
  Future<List<StockItem>> getStockItems() async {
    final data = await client.fetchCollection(
      collectionName: 'StockItem',
      fetchList: [
        'GUID',
        'NAME',
        'PARENT',
        'BASEUNITS',
        'STANDARDCOST',
        'STANDARDPRICE',
        'CLOSINGBALANCE',
        'CLOSINGVALUE',
        'OPENINGBALANCE',
        'OPENINGVALUE'
      ],
    );

    return data.map((json) => StockItem.fromXmlMap(json)).toList();
  }
}
