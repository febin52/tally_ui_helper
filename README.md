# flutter_tally_erp 📊

[![Pub Version](https://img.shields.io/pub/v/flutter_tally_erp.svg)](https://pub.dev/packages/flutter_tally_erp)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A complete Flutter package to instantly connect your mobile or web app with **Tally ERP 9** and **Tally Prime** via the official XML over HTTP API. Generate a mobile ERP interface in minutes without writing custom backend code!

No reverse engineering. No proprietary Tally components. Just clean HTTP XML communication with your localized Tally Server acting as a client.

## 🚀 Features

* **Tally HTTP Client**: Send raw XML requests and receive beautifully parsed Dart objects.
* **Auto-Generated ERP UI**: Use `TallyERP().generateApp()` to instantly build an ERP dashboard, sales records, inventory, and ledgers.
* **Core Business Models**: Out-of-the-box models for `Ledger`, `Voucher`, `StockItem`, and `Company`.
* **Sync Engine**: Built-in background sync capabilities to keep your app updated (`TallySyncEngine`).
* **Clean Architecture**: Highly modular, fully typed, Null-Safe, and easily extensible.
* **Ready-to-use Widgets**: Includes `LedgerList`, `StockTable`, `VoucherViewer`, and `ERPDashboard`.

## 🛠 Prerequisites (Tally Configuration)

Before using this plugin, ensure your Tally ERP 9 / Tally Prime is configured to accept HTTP requests:

1. Open Tally and load your Company.
2. Go to **Gateway of Tally** > **F12: Configure** > **Advanced Configuration**.
3. Set **Tally is acting as** to `Both` or `Server`.
4. Note down the **Port Number** (usually `9000`).
5. Ensure the firewall on the host machine allows inbound connections on this port.

## 📦 Installation

Add this block to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_tally_erp: ^1.0.0
```

## 💻 Quick Start: The 3-Minute ERP

Want a complete ERP mobile app instantly? Just point the package to your Tally IP.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_tally_erp/flutter_tally_erp.dart';

void main() {
  final erp = TallyERP(
    host: "http://192.168.1.10:9000", // Your Tally Server IP
    enableSync: true,
  );

  runApp(
    erp.generateApp(title: 'My Mobile ERP')
  );
}
```

This single block of code gives you a fully functional app with:
* Dashboard Summaries
* Sales Voucher Viewers
* Inventory/Stock Item Tables
* Customer & Ledger lists

---

## 🔧 Advanced Usage (Custom UI)

If you just want to use the package as an API client to build your own custom UI:

### 1. Initialize the Client

```dart
final client = TallyClient(host: "http://192.168.1.10:9000");
```

### 2. Fetch Services

#### Ledgers
```dart
final ledgerService = LedgerService(client);
final List<Ledger> ledgers = await ledgerService.getLedgers();

for (var ledger in ledgers) {
  print('\${ledger.name}: \${ledger.closingBalance}');
}
```

#### Vouchers & Transactions
```dart
final voucherService = VoucherService(client);
// Get all Sales
final List<Voucher> sales = await voucherService.getVouchersByType('Sales');
```

#### Inventory
```dart
final inventoryService = InventoryService(client);
final List<StockItem> items = await inventoryService.getStockItems();
```

### 3. Background Sync

Keep data fresh without manual refresh using `TallySyncEngine`.

```dart
final syncEngine = TallySyncEngine(
  client: client,
  interval: Duration(minutes: 10),
);

syncEngine.addListener(() {
  print("Sync status: \${syncEngine.isSyncing}");
});

syncEngine.start();
```

## 🧪 Error Handling

The package gracefully handles HTTP timeouts, server offline states, and invalid XML issues:

```dart
try {
  final ledgers = await ledgerService.getLedgers();
} catch (e) {
  print("Failed to connect to Tally OR invalid XML response: \$e");
}
```

## 🤝 Contributing
Contributions are welcome! Please create an issue or pull request if you want to add new reports, optimize XML queries, or add new UI widgets.

## 📄 License
This project is licensed under the MIT License - see the LICENSE file for details.
