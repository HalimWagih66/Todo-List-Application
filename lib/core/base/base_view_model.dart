import 'package:flutter/material.dart';
import 'base_navigator.dart';

class BaseViewModel<Nav extends BaseNavigator> extends ChangeNotifier{
  late Nav navigator;
  void goToScreen(String routeName){
    navigator.pushScreen(routeName);
  }
  void goToScreenAndRemoveUntil(String routeName){
    navigator.pushScreenAndRemoveUntil(routeName);
  }
}