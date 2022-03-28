import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../services/display.service.dart';


class CalcButtonViewModel extends BaseViewModel {
  final _displayService = locator<DisplayService>();

  void pressed(String text) => _displayService.updateDisplay(text);
}
