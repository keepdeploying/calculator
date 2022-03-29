class Calculation {
  final List<dynamic> display;
  final String result;

  const Calculation(this.display, this.result);

  @override
  toString() => '${display.map((e) => e.toString()).join(' ')} = $result';
}
