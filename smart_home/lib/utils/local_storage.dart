import 'package:hive/hive.dart';

import '../environment/app_config.dart';

final LocalStorage = HiveLocalStorage();

class HiveLocalStorage {
  final box = Hive.box(FlavorConfig.values.LocalDBName);

  void open() {
    Hive.openBox(FlavorConfig.values.LocalDBName);
  }

  String getString(String key, {String? defaultValue}) {
    try {
      return box.get(key, defaultValue: defaultValue ?? '');
    } catch (_) {
      return '';
    }
  }

  int getInt(String key, {int? defaultValue}) {
    try {
      return box.get(key, defaultValue: defaultValue ?? -1);
    } catch (_) {
      return -1;
    }
  }

  bool getBool(String key, {bool? defaultValue}) {
    try {
      return box.get(key, defaultValue: defaultValue ?? false);
    } catch (_) {
      return false;
    }
  }

  dynamic getObject(String key) {
    try {
      return box.get(key);
    } catch (_) {
      return null;
    }
  }

  void save(String key, dynamic value) {
    box.put(key, value);
  }

  void clearUserInfo() {
    LocalStorage.save(LocalStorageKey.name, '');
    LocalStorage.save(LocalStorageKey.access_token, '');
    LocalStorage.save(LocalStorageKey.refresh_token, '');
    LocalStorage.save(LocalStorageKey.phoneNumber, '');
    LocalStorage.save(LocalStorageKey.position, '');
    LocalStorage.save(LocalStorageKey.departmentName, '');
    LocalStorage.save(LocalStorageKey.departmentCode, '');
    LocalStorage.save(LocalStorageKey.typeUser, '');
    LocalStorage.save(LocalStorageKey.isLogin, false);
  }

  void saveUserInfo({
    String? name,
    String? accessToken,
    String? refreshToken,
    String? phoneNumber,
    String? position,
    String? departmentName,
    String? departmentCode,
    String? typeUser,
    String? tokenType,
  }) {
    LocalStorage.save(LocalStorageKey.name, name ?? '');
    LocalStorage.save(LocalStorageKey.access_token, accessToken ?? '');
    LocalStorage.save(LocalStorageKey.refresh_token, refreshToken ?? '');
    LocalStorage.save(LocalStorageKey.phoneNumber, phoneNumber ?? '');
    LocalStorage.save(LocalStorageKey.position, position ?? '');
    LocalStorage.save(LocalStorageKey.departmentName, departmentName ?? '');
    LocalStorage.save(LocalStorageKey.departmentCode, departmentCode ?? '');
    LocalStorage.save(LocalStorageKey.typeUser, typeUser ?? '');
    LocalStorage.save(LocalStorageKey.tokenType, tokenType ?? '');
    LocalStorage.save(LocalStorageKey.isLogin, true);
  }
}

class LocalStorageKey {
  static const String name = 'name';
  static const String access_token = 'access_token';
  static const String refresh_token = 'refresh_token';
  static const String phoneNumber = 'phoneNumber';
  static const String position = 'position';
  static const String departmentName = 'departmentName';
  static const String departmentCode = 'departmentCode';
  static const String typeUser = 'typeUser';
  static const String tokenType = 'tokenType';
  static const String isLogin = 'isLogin';
}
