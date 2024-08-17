AppConfig appConfig = AppConfig(version: 26, codeName: '1.0.5');

class AppConfig {
  int version;
  String codeName;
  Uri updateUri = Uri.parse(
      'https://api.github.com/repos/Dahalshrayesh/shrayesh/releases/latest');
  AppConfig({required this.version, required this.codeName});
}
