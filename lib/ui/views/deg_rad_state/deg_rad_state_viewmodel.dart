import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../services/deg_rad.service.dart';

class DegRadStateViewModel extends ReactiveViewModel {
  final _degRadService = locator<DegRadService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_degRadService];

  String get current => _degRadService.current.toString().split('.')[1];
}
