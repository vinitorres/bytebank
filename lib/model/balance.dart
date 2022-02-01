import 'package:flutter/widgets.dart';

class Balance extends ChangeNotifier {
  double current;

  Balance(this.current);

  add(double value) {
    current += value;
    notifyListeners();
  }

  remove(double value) {
    current -= value;
    notifyListeners();
  }

  @override
  String toString() {
    return 'R\$ $current';
  }
}
