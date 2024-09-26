import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:test_prj/domain/repository/local_storage_repository.dart';
import 'package:test_prj/domain/repository/login_repository.dart';
import 'package:test_prj/domain/repository/profile_data_repository.dart';
import 'package:test_prj/domain/validators/email_validator.dart';
import 'package:test_prj/domain/validators/password_validator.dart';
import 'package:test_prj/presentation/login_screens/login_screen.dart';
import 'package:test_prj/resources/app_colors.dart';

class TestApp extends StatelessWidget {
  TestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LocalStorageRepository>(
          create: (context) => LocalStorageRepository(),
        ),
        RepositoryProvider<EmailValidator>(
          create: (context) => EmailValidator(),
        ),
        RepositoryProvider<PasswordValidator>(
          create: (context) => PasswordValidator(),
        ),
        RepositoryProvider<LoginRepository>(
          create: (context) => LoginRepository(),
        ),
        RepositoryProvider<ProfileDataRepository>(
          create: (context) => ProfileDataRepository(),
        )
      ],
      child: Builder(builder: (context) {
        return GlobalLoaderOverlay(
          overlayColor: AppColors.black_26,
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark.copyWith(
              systemNavigationBarDividerColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
            child: const OverlaySupport.global(
              child: MaterialApp(
                title: "Test App",
                debugShowCheckedModeBanner: false,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                home: LogInScreen(),
              ),
            ),
          ),
        );
      }),
    );
  }
}
