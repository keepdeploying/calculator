import 'dart:collection';

import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../models/calculation.dart';

@singleton
class HistoryService with ReactiveServiceMixin {
  final _current = ReactiveValue<Queue<Calculation>>(Queue());
  Queue<Calculation> get current => _current.value;

  HistoryService() {
    listenToReactiveValues([_current]);
  }

  void record(Calculation calc) {
    _current.value.add(calc);
    if (_current.value.length > 3) {
      _current.value.removeFirst();
    }
    notifyListeners();
  }
}
