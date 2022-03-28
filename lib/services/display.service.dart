import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@singleton
class DisplayService with ReactiveServiceMixin {
  final ReactiveValue<String> _current = ReactiveValue<String>('');
  String get current => _current.value;

  DisplayService() {
    listenToReactiveValues([_current]);
  }

  void updateDisplay(String text) {
    _current.value += text;
    notifyListeners();
  }
}
