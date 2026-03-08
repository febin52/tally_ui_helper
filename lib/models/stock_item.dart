/// Represents a Stock Item in Tally inventory
class StockItem {
  /// Unique identifier of the stock item
  final String guid;

  /// Name of the stock item
  final String name;

  /// Parent stock group
  final String parent;

  /// Base units of measure (e.g., Nos, Kgs)
  final String baseUnits;

  /// Standard cost of the item
  final double standardCost;

  /// Standard selling price of the item
  final double standardPrice;

  /// Closing balance quantity
  final double closingBalance;

  /// Closing balance value
  final double closingValue;

  /// Opening balance quantity
  final double openingBalance;

  /// Opening balance value
  final double openingValue;

  /// Creates a [StockItem] instance
  StockItem({
    required this.guid,
    required this.name,
    required this.parent,
    required this.baseUnits,
    required this.standardCost,
    required this.standardPrice,
    required this.closingBalance,
    required this.closingValue,
    required this.openingBalance,
    required this.openingValue,
  });

  /// Creates a [StockItem] from an XML map
  factory StockItem.fromXmlMap(Map<String, String> map) {
    double parseDouble(String key) {
      final value = map[key] ?? '0';
      final numericPart = value.replaceAll(RegExp(r'[^\\d\\.-]'), '');
      return double.tryParse(numericPart) ?? 0.0;
    }

    return StockItem(
      guid: map['GUID'] ?? '',
      name: map['NAME'] ?? '',
      parent: map['PARENT'] ?? '',
      baseUnits: map['BASEUNITS'] ?? '',
      standardCost: parseDouble('STANDARDCOST'),
      standardPrice: parseDouble('STANDARDPRICE'),
      closingBalance: parseDouble('CLOSINGBALANCE'),
      closingValue: parseDouble('CLOSINGVALUE'),
      openingBalance: parseDouble('OPENINGBALANCE'),
      openingValue: parseDouble('OPENINGVALUE'),
    );
  }

  /// Converts the stock item into a JSON map
  Map<String, dynamic> toJson() => {
        'guid': guid,
        'name': name,
        'parent': parent,
        'baseUnits': baseUnits,
        'standardCost': standardCost,
        'standardPrice': standardPrice,
        'closingBalance': closingBalance,
        'closingValue': closingValue,
      };
}
