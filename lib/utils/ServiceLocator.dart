import 'package:flutter_hud/domain/album/ServerAlbumRepo.dart';
import 'package:flutter_hud/domain/wifi/BluetoothManager.dart';
import 'package:flutter_hud/domain/wifi/WifiManager.dart';

class ServiceLocator {
  static final ServiceLocator instance = ServiceLocator._internal();

  ServiceLocator._internal();

  final WifiManager _wifiManager = WifiManager();
  final BluetoothManager _bluetoothManager = new BluetoothManager();

  WifiManager getWifiManager() {
    return _wifiManager;
  }

  BluetoothManager getBluetoothManager() {
    return _bluetoothManager;
  }

  AlbumRepo getAlbumRepo() {
    return new ServerAlbumRepo();
  }
}
