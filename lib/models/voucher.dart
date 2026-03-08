/// Represents a Tally Voucher (Transaction)
class Voucher {
  /// Unique identifier of the voucher
  final String guid;

  /// The voucher number/ID
  final String voucherNumber;

  /// Date of the voucher transaction
  final String date;

  /// Type of voucher (e.g., Sales, Purchase, Receipt)
  final String voucherType;

  /// Name of the primary party ledger involved
  final String partyLedgerName;

  /// Total amount of the voucher
  final double amount;

  /// Narration or description of the transaction
  final String narration;

  /// List of individual ledger entries in this voucher
  final List<VoucherLedgerEntry> ledgerEntries;

  /// Creates a [Voucher] instance
  Voucher({
    required this.guid,
    required this.voucherNumber,
    required this.date,
    required this.voucherType,
    required this.partyLedgerName,
    required this.amount,
    required this.narration,
    this.ledgerEntries = const [],
  });

  /// Parses a Tally XML Map to create a [Voucher]
  factory Voucher.fromXmlMap(Map<String, String> map) {
    double parseDouble(String key) {
      final value = map[key] ?? '0';
      final numericPart = value.replaceAll(RegExp(r'[^\\d\\.-]'), '');
      return double.tryParse(numericPart) ?? 0.0;
    }

    return Voucher(
      guid: map['GUID'] ?? '',
      voucherNumber: map['VOUCHERNUMBER'] ?? '',
      date: map['DATE'] ?? '',
      voucherType: map['VOUCHERTYPENAME'] ?? '',
      partyLedgerName: map['PARTYLEDGERNAME'] ?? '',
      amount: parseDouble('AMOUNT'),
      narration: map['NARRATION'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'guid': guid,
        'voucherNumber': voucherNumber,
        'date': date,
        'voucherType': voucherType,
        'partyLedgerName': partyLedgerName,
        'amount': amount,
        'narration': narration,
      };
}

class VoucherLedgerEntry {
  final String ledgerName;
  final double amount;
  final bool isDeemedPositive;

  VoucherLedgerEntry({
    required this.ledgerName,
    required this.amount,
    required this.isDeemedPositive,
  });

  factory VoucherLedgerEntry.fromXmlMap(Map<String, String> map) {
    final amountString = map['AMOUNT'] ?? '0';
    final numericPart = amountString.replaceAll(RegExp(r'[^\\d\\.-]'), '');
    final parsedAmount = double.tryParse(numericPart) ?? 0.0;

    return VoucherLedgerEntry(
      ledgerName: map['LEDGERNAME'] ?? '',
      amount: parsedAmount.abs(),
      isDeemedPositive: map['ISDEEMEDPOSITIVE'] == 'Yes', // Dr/Cr
    );
  }
}
