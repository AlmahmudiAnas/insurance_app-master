import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class OnBoardingProvider extends ChangeNotifier {
  int currentIndex = 0;

  void changeIndex(value) {
    currentIndex = value;
    notifyListeners();
  }

  Widget animation(int index, int delay, Widget child) {
    if (index == 1) {
      return FadeInDown(
        delay: Duration(milliseconds: delay),
        child: child,
      );
    }
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      child: child,
    );
  }
}
