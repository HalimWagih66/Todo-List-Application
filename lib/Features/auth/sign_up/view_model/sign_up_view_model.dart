import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_application/Features/auth/login/view/login_view.dart';
import 'package:todo_list_application/core/base/base_navigator.dart';

import '../../../../core/base/base_view_model.dart';

abstract class SignUpNavigator extends BaseNavigator{

}
class SignUpViewModel extends BaseViewModel<SignUpNavigator>{
  bool isHidePassword = true;
  IconData eyePassword = Icons.remove_red_eye;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void>createAccount(String name,String email,String password)async{
    navigator.showLoading();
    try{
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      navigator.pushScreenAndRemoveUntil(LoginView.routeName);
      navigator.showMessageSnackPar(message: "A message has been sent to your account to activate the account please activate the account and then come back again to log in");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator.hideDialogLoading();
        navigator.showResult(message: "The password provided is too weak.", dialogType: DialogType.warning);
      } else if (e.code == 'email-already-in-use') {
        navigator.hideDialogLoading();
        navigator.showResult(message: "The account already exists for that email.", dialogType: DialogType.warning);
      }
    } catch (e) {
      navigator.hideDialogLoading();
      navigator.showResult(message: e.toString(), dialogType: DialogType.error);
    }
  }
  void onPressedSuffixIcon(){
    isHidePassword = !isHidePassword;
    eyePassword = isHidePassword == true
        ? Icons.remove_red_eye
        : Icons.remove_red_eye_outlined;
    notifyListeners();
  }
}