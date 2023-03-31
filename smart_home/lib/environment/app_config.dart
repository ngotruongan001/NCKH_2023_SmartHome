import 'app_environment.dart';

class FlavorValues {
  FlavorValues({
    required this.server,
    required this.baseUrl,
    required this.appName,
    required this.LocalDBName,
  });
  final String server;
  final String baseUrl;
  final String appName;
  final String LocalDBName;
}

abstract class FlavorConfig {
  static AppEnvironment? _flavor;
  static FlavorValues? _values;
  static void set(AppEnvironment flavor, FlavorValues values) {
    _flavor = flavor;
    _values = values;
  }

  static bool isInitialized() => _flavor != null;

  static bool isDev() => _flavor! == AppEnvironment.DEV;

  static bool isProduction() => _flavor! == AppEnvironment.PROD;

  static FlavorValues get values => _values!;
}

void setFlavorDevelopment() {
  FlavorConfig.set(
    AppEnvironment.DEV,
    FlavorValues(
      appName: 'AlphaLog',
      server: 'https://alphalog.com/',
      baseUrl: 'http://50.112.237.164:8010/',
      LocalDBName: 'AppLocalStorage',
    ),
  );
}

void setFlavorProduction() {
  FlavorConfig.set(
    AppEnvironment.PROD,
    FlavorValues(
      appName: 'AlphaLog',
      server: 'https://alphalog.com/',
      baseUrl: 'http://50.112.237.164:8010/',
      LocalDBName: 'AppLocalStorage',
    ),
  );
}
