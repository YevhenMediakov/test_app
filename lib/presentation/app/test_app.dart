import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_prj/presentation/login_screens/login_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:test_prj/resources/app_colors.dart';

class TestApp extends StatelessWidget {
  TestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayColor: AppColors.black_26,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: AppColors.white,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: OverlaySupport.global(
          child: MaterialApp(
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle.dark,
              ),
            ),
            title: "Test App",
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            // supportedLocales: AppLanguages.values.map((e) => Locale(e.locale)),
            // builder: (context, widget) {
            //   ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            //     return AppCustomWidgetBuildingError(errorDetails: errorDetails);
            //   };
            //   return AppEnvironmentBanner(child: widget ?? const SizedBox());
            // },
            home: Builder(
              builder: (context) {
                return const LogInScreen();
              },
            ),
          ),
        ),
      ),
    );
  }
}
