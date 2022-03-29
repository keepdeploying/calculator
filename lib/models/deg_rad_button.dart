import 'button_type.dart';
import 'calc_button.dart';

class DegRadButton extends CalcButton {
  @override
  // ignore: overridden_fields
  String text = '';

  DegRadButton() : super('', ButtonType.degRad);

  @override
  toString() => text;
}
