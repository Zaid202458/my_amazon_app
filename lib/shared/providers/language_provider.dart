import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// مزود إدارة اللغات في التطبيق
/// يستخدم للتحكم في لغة التطبيق وحفظ تفضيلات المستخدم
class LanguageProvider with ChangeNotifier {
  /// اللغة الحالية للتطبيق، الافتراضية هي العربية
  Locale _currentLocale = const Locale('ar');
  
  /// كائن لحفظ التفضيلات المحلية
  final SharedPreferences _prefs;

  /// منشئ الصنف، يأخذ كائن SharedPreferences ويقوم بتحميل اللغة المحفوظة
  LanguageProvider(this._prefs) {
    _loadSavedLanguage();
  }

  /// الحصول على اللغة الحالية
  Locale get currentLocale => _currentLocale;

  /// تحميل اللغة المحفوظة مسبقاً من الذاكرة المحلية
  void _loadSavedLanguage() {
    String? languageCode = _prefs.getString('languageCode');
    if (languageCode != null) {
      _currentLocale = Locale(languageCode);
    }
  }

  /// تغيير لغة التطبيق إلى اللغة المحددة
  Future<void> changeLanguage(String languageCode) async {
    _currentLocale = Locale(languageCode);
    await _prefs.setString('languageCode', languageCode);
    notifyListeners();
  }

  /// التحقق ما إذا كانت اللغة الحالية هي العربية
  bool get isArabic => _currentLocale.languageCode == 'ar';

  /// تبديل اللغة بين العربية والإنجليزية
  Future<void> toggleLanguage() async {
    if (isArabic) {
      await changeLanguage('en');
    } else {
      await changeLanguage('ar');
    }
  }
}
