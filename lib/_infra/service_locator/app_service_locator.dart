import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:test_prj/_infra/service_locator/app_service_locator_blocs.dart';
import 'package:test_prj/_infra/service_locator/app_service_locator_local_services.dart';
import 'package:test_prj/_infra/service_locator/app_service_locator_repositories.dart';
import 'package:test_prj/_infra/service_locator/app_service_locator_validators.dart';
import 'package:test_prj/_infra/service_locator/app_service_provider_use_cases.dart';

final getIt = GetIt.instance;

class AppServiceLocator {
  /// Initializes all dependencies declared inside the [AppServiceLocator].
  /// Should only be called before the [runApp] method
  static Future<void> setup() async {
    await AppServiceLocatorLocalServices.setup(instance: getIt);
    await AppServiceLocatorRepositories.setup(instance: getIt);
    await AppServiceLocatorUseCases.setup(instance: getIt);
    await AppServiceLocatorBlocs.setup(instance: getIt);
    await AppServiceLocatorValidators.setup(instance: getIt);
  }
}
