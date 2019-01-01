import 'package:flutter_hud/domain/album/ServerAlbumRepo.dart';
import 'package:flutter_hud/domain/wifi/WifiManager.dart';

class ServiceLocator {
  static final ServiceLocator instance = ServiceLocator._internal();

  ServiceLocator._internal();

  final WifiManager _wifiManager = WifiManager();

  WifiManager getWifiManager() {
    return _wifiManager;
  }

  AlbumRepo getAlbumRepo() {
    return new ServerAlbumRepo();
  }
}
