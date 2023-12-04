import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_application/core/widget/dialogs/show_loading.dart';
import 'package:todo_list_application/core/widget/dialogs/show_message.dart';
import '../widget/dialogs/hide_dialog.dart';
import '../widget/dialogs/show_message_dialog.dart';
import 'base_navigator.dart';
import 'base_view_model.dart';

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late VM viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel.navigator = this;
  }

  VM initViewModel();

  @override
  void showLoading({String showMessage = "Loading"}) {
    showLoadingDialog(context);
  }

  @override
  void showMessageSnackPar({required String message}){
    showMessageWithSnackPar(message: message,context: context);
  }
  @override
  void showResult(
      {required String message,
      required DialogType dialogType,
      String? title,
      Function? nigAction,
      String? nigActionName,
      Function? posAction,
      String? posActionName}) {
    showMessageWithDialog(
        context: context,
        message: message,
        dialogType: dialogType,
        title: title,
        nigAction: nigAction,
        nigActionName: nigActionName,
        posAction: posAction,
        posActionName: posActionName
    );
  }

  @override
  void hideDialogLoading() {
    hideDialog(context);
  }
  @override
  void pushScreenAndRemoveUntil(String routeName){
    Navigator.pushReplacementNamed(context, routeName);
  }
  @override
  void pushScreen(String routeName){
    Navigator.pushNamed(context, routeName);
  }
}
