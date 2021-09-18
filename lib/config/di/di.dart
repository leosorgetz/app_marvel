import 'package:app_marvel/src/core/di.dart';
import 'package:app_marvel/src/ui/di.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies({bool isTesting = false}) async {
  final coreDependencies = CoreDependencies(getIt);
  final uiDependencies = UiDependencies(getIt);
  coreDependencies.initDependencies();
  uiDependencies.initDependencies();
}
