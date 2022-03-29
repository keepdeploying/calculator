import '../services/display.service.dart';
import '../ui/views/calc_button/calc_button_view.dart';

/// Tells what the [DisplayService] how to handle the pressed action from a
/// given [CalcButtonView]
enum ButtonType {
  /// Toggles Calculator context between DEG and RAD
  degRad,
  
  /// Deletes display text once from the right
  delete,

  /// Executes contents of the display. Carries out a calculation.
  equals,

  /// Adds the number to the display
  number,

  /// Execute a given operator on display's contents
  operatorExecute,

  /// Adds a given operator to the display.
  operatorWait,
}
