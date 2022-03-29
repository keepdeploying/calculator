import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../services/display.service.dart';

class DisplayViewModel extends ReactiveViewModel {
  final _displayService = locator<DisplayService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_displayService];

  String get current => _displayService.current;
  String get result => _displayService.result;
}
