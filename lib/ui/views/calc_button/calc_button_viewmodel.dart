import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../models/calc_button.dart';
import '../../../services/display.service.dart';

class CalcButtonViewModel extends BaseViewModel {
  final _displayService = locator<DisplayService>();
  
  void pressed(CalcButton calcButton) =>
      _displayService.updateDisplay(calcButton);
}
