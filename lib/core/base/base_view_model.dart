
import 'package:flutter/material.dart';
import 'base_navigator.dart';

class BaseViewModel<Nav extends BaseNavigator> extends ChangeNotifier{
  late Nav navigator;
  void goToScreen({required String routeName,Object? arg}){
    navigator.pushScreen(routeName: routeName,arg: arg);
  }
  void goToScreenAndRemoveUntil({required String routeName, Object? arg}){
    navigator.pushScreenAndRemoveUntil(routeName: routeName,arg: arg);
  }
}