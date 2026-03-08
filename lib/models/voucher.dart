class Voucher {
  final String guid;
  final String voucherNumber;
  final String date;
  final String voucherType;
  final String partyLedgerName;
  final double amount;
  final String narration;
  final List<VoucherLedgerEntry> ledgerEntries;

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
