import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Balance with ChangeNotifier {
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
