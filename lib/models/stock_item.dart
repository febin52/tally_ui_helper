class StockItem {
  final String guid;
  final String name;
  final String parent;
  final String baseUnits;
  final double standardCost;
  final double standardPrice;
  final double closingBalance;
  final double closingValue;
  final double openingBalance;
  final double openingValue;

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
