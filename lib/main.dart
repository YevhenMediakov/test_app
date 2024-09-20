import 'package:flutter/material.dart';
import 'package:test_prj/_infra/service_locator/app_service_locator.dart';
import 'package:test_prj/presentation/app/test_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppServiceLocator.setup();

  runApp(TestApp());
}