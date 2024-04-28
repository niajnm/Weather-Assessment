import 'package:flutter/material.dart';

enum AppLanguage {
  bn, // Bangla
  en, // English
}

extension AppLanguageTitle on AppLanguage {
  String getTitle() {
    switch (this) {
      case AppLanguage.bn:
        return "🇧🇩 বাংলা";
      case AppLanguage.en:
        return "🇬🇧 English";
      default:
        return "🇬🇧 English";
    }
  }
}

    List<Locale> getSupportedLocal() {
    return AppLanguage.values.map((language) => Locale(language.name)).toList();
  }