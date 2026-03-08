import 'dart:async';
import 'package:flutter/foundation.dart';
import '../core/tally_client.dart';

class TallySyncEngine extends ChangeNotifier {
  final TallyClient client;
  final Duration interval;

  Timer? _timer;
  bool _isSyncing = false;
  DateTime? _lastSyncTime;

  bool get isSyncing => _isSyncing;
  DateTime? get lastSyncTime => _lastSyncTime;

  TallySyncEngine({
    required this.client,
    this.interval = const Duration(minutes: 5),
  });

  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(interval, (_) => syncNow());
    syncNow(); // First sync immediately
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> syncNow() async {
    if (_isSyncing) return;

    _isSyncing = true;
    notifyListeners();

    try {
      // In a real app we'd broadcast sync events or save to local DB
      // Here we just trigger a connection check / sync pulse
      await client.getCompanies();
      _lastSyncTime = DateTime.now();
    } catch (e) {
      debugPrint('Tally Sync Failed: $e');
    } finally {
      _isSyncing = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }
}
