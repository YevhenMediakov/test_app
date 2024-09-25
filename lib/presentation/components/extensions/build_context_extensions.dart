import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuildContextExtensions on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this)!;

  Locale get appLocale => Localizations.localeOf(this);
}
