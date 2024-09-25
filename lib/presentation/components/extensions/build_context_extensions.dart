import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:test_prj/presentation/components/loading/app_loading_overlay.dart';

extension BuildContextExtensions on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this)!;

  Locale get appLocale => Localizations.localeOf(this);

  loading(bool show) {
    if (show) {
      showLoading();
    } else {
      hideLoading();
    }
  }

  showLoading() {
    loaderOverlay.show(widgetBuilder: (_) {
      return const AppLoadingOverlay();
    });
  }

  hideLoading() {
    loaderOverlay.hide();
  }
//
// showErrorException(Exception? exception) {
//   if (exception != null) {
//     final message = ExceptionToErrorMessageAdapter.getMessage(
//         this, exception);
//     showAlertAppSnackBar(title: message);
//   }
// }
//
// showAlertAppSnackBar({
//   required final String title,
// }) {
//   ScaffoldMessenger.of(this).hideCurrentSnackBar();
//   ScaffoldMessenger.of(this).showSnackBar(
//     AppSnackBar.alert(text: title),
//   );
// }
//
// showInformationAppSnackBar({
//   required final String title,
//   final VoidCallback? onAction
// }) {
//   ScaffoldMessenger.of(this).hideCurrentSnackBar();
//   ScaffoldMessenger.of(this).showSnackBar(
//     AppSnackBar.information(
//       text: title,
//       onAction: onAction,
//     ),
//   );
// }
//
// showPermanentAlertAppSnackBar({
//   required final String title,
//   final VoidCallback? onAction
// }) {
//   ScaffoldMessenger.of(this).hideCurrentSnackBar();
//   ScaffoldMessenger.of(this).showSnackBar(
//     AppSnackBar.permanentAlert(
//       text: title,
//       onAction: onAction,
//     ),
//   );
// }
}
