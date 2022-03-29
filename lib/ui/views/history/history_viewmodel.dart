import 'dart:collection';

import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../models/calculation.dart';
import '../../../services/history.service.dart';

class HistoryViewModel extends BaseViewModel {
  final _historyService = locator<HistoryService>();

  Queue<Calculation> get current => _historyService.current;
}
