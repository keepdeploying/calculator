// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../services/calculator.service.dart' as _i3;
import '../services/deg_rad.service.dart' as _i4;
import '../services/history.service.dart' as _i5;
import '../services/display.service.dart' as _i6;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.CalculatorService>(_i3.CalculatorService());
  gh.singleton<_i4.DegRadService>(_i4.DegRadService());
  gh.singleton<_i5.HistoryService>(_i5.HistoryService());
  gh.singleton<_i6.DisplayService>(_i6.DisplayService());
  return get;
}
