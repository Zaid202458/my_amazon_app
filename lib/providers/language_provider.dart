import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  Locale _currentLocale = const Locale('ar');
  final SharedPreferences _prefs;

  LanguageProvider(this._prefs) {
    _loadSavedLanguage();
  }

  Locale get currentLocale => _currentLocale;

  void _loadSavedLanguage() {
    String? languageCode = _prefs.getString('languageCode');
    if (languageCode != null) {
      _currentLocale = Locale(languageCode);
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    _currentLocale = Locale(languageCode);
    await _prefs.setString('languageCode', languageCode);
    notifyListeners();
  }

  bool get isArabic => _currentLocale.languageCode == 'ar';
}
