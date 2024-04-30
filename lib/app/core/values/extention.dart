import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


extension ThemeData on BuildContext {
  TextTheme get appThemeText => Theme.of(this).textTheme;
   AppLocalizations get lanValue =>  AppLocalizations.of(this)!;

}