import 'package:awesome_dialog/awesome_dialog.dart';

abstract class BaseNavigator {
  void showLoading({String showMessage = "Loading"});
  void showMessageSnackPar({required String message});
  void showResult({required String message,required DialogType dialogType,String? title,Function? nigAction,String? nigActionName,Function? posAction,String? posActionName});
  void hideDialogLoading();
  void pushScreenAndRemoveUntil(String routeName);
  void pushScreen(String routeName);
}

