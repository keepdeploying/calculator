import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../models/calc_button.dart';
import '../../../services/display.service.dart';

class CalcButtonViewModel extends ReactiveViewModel {
  final _displayService = locator<DisplayService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_displayService];

  String get degRad {
    return (_displayService.degRad == DegRad.DEG ? DegRad.RAD : DegRad.DEG)
        .toString()
        .split('.')[1];
  }

  void pressed(CalcButton calcButton) =>
      _displayService.updateDisplay(calcButton);
}
