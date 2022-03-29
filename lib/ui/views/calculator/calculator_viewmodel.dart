import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../services/display.service.dart';

class CalculatorViewModel extends ReactiveViewModel {
  final _displayService = locator<DisplayService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_displayService];

  String get current => _displayService.current;
  DegRad get degRad => _displayService.degRad;
  String get result => _displayService.result;
}
