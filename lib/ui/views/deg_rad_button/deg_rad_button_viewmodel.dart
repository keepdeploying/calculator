import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../services/deg_rad.service.dart';

class DegRadButtonViewModel extends ReactiveViewModel {
  final _degRadService = locator<DegRadService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_degRadService];

  String get current {
    return (_degRadService.current == DegRad.DEG ? DegRad.RAD : DegRad.DEG)
        .toString()
        .split('.')[1];
  }

  void toggle() => _degRadService.toggle();
}
