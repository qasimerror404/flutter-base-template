import 'package:connectivity_plus/connectivity_plus.dart';

/// Network connectivity information
class NetworkInfo {
  final Connectivity connectivity;

  NetworkInfo(this.connectivity);

  /// Check if device is connected to internet
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  /// Get connectivity type
  Future<ConnectivityResult> get connectivityType async {
    final results = await connectivity.checkConnectivity();
    return results.isNotEmpty ? results.first : ConnectivityResult.none;
  }

  /// Stream of connectivity changes
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      connectivity.onConnectivityChanged;

  /// Check if connected to WiFi
  Future<bool> get isWifi async {
    final result = await connectivityType;
    return result == ConnectivityResult.wifi;
  }

  /// Check if connected to mobile data
  Future<bool> get isMobile async {
    final result = await connectivityType;
    return result == ConnectivityResult.mobile;
  }
}

