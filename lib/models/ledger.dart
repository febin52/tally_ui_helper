class Ledger {
  final String guid;
  final String name;
  final String parent;
  final double closingBalance;
  final String currency;
  final String address;
  final String taxNumber;
  final String email;

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
