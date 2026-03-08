/// Represents a Ledger account in Tally
class Ledger {
  /// Unique identifier of the ledger
  final String guid;

  /// Name of the ledger
  final String name;

  /// Parent group of the ledger (e.g., Sundry Debtors)
  final String parent;

  /// Final closing balance of the ledger
  final double closingBalance;

  /// Currency of the balance
  final String currency;

  /// Primary address of the party
  final String address;

  /// Tax / GST registration number
  final String taxNumber;

  /// Email address of the party
  final String email;

  /// Creates a new [Ledger] instance
  Ledger({
    required this.guid,
    required this.name,
    required this.parent,
    required this.closingBalance,
    required this.currency,
    required this.address,
    required this.taxNumber,
    required this.email,
  });

  /// Parses a Tally XML Map to create a [Ledger].
  factory Ledger.fromXmlMap(Map<String, String> map) {
    String balanceString = map['CLOSINGBALANCE'] ?? '0';
    // Tally negative means debit, positive means credit.
    // Usually represented with trailing Dr or Cr
    double parsedBalance = 0;
    try {
      if (balanceString.isNotEmpty) {
        String numericPart =
            balanceString.replaceAll(RegExp(r'[^\\d\\.-]'), '');
        parsedBalance = double.tryParse(numericPart) ?? 0;
      }
    } catch (e) {
      // Ignore
    }

    return Ledger(
      guid: map['GUID'] ?? '',
      name: map['NAME'] ?? '',
      parent: map['PARENT'] ?? '',
      closingBalance: parsedBalance,
      currency: map['CURRENCYNAME'] ?? 'INR',
      address: map['ADDRESS'] ?? '',
      taxNumber: map['PARTYGSTIN'] ?? map['INCOMETAXNUMBER'] ?? '',
      email: map['EMAIL'] ?? '',
    );
  }

  /// Converts the ledger into a JSON map
  Map<String, dynamic> toJson() => {
        'guid': guid,
        'name': name,
        'parent': parent,
        'closingBalance': closingBalance,
        'currency': currency,
        'address': address,
        'taxNumber': taxNumber,
        'email': email,
      };
}
