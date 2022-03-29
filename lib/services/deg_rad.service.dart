import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

// ignore: constant_identifier_names
enum DegRad { DEG, RAD }

@singleton
class DegRadService with ReactiveServiceMixin {
  final _current = ReactiveValue<DegRad>(DegRad.DEG);
  DegRad get current => _current.value;

  DegRadService() {
    listenToReactiveValues([_current]);
  }

  void toggle() {
    _current.value = _current.value == DegRad.DEG ? DegRad.RAD : DegRad.DEG;
    notifyListeners();
  }
}
