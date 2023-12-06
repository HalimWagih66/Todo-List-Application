import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_application/Features/auth/login/navigator/login_navigator.dart';
import 'package:todo_list_application/Features/onboarding/view/using_app_view.dart';
import 'package:todo_list_application/core/base/base_view_model.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator>{
  bool isHidePassword = true;
  IconData eyePassword = Icons.remove_red_eye;

  Future<void> login(String email,String password)async {
    navigator.showLoading();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email,
          password: password
      );
      navigator.hideDialogLoading();
      if (userCredential.user?.emailVerified == true) {
        navigator.showMessageSnackPar(message: "Success");
        navigator.pushScreenAndRemoveUntil(OnBoardingView.routeName);
      } else {
        navigator.showMessageSnackPar(message: "Please activate the account");
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if(e.code == "invalid-credential"){
        navigator.hideDialogLoading();
        navigator.showMessageSnackPar(message: "There is an error in the email or password");
      }
      else{
        navigator.hideDialogLoading();
        navigator.showMessageSnackPar(message: e.toString());
      }
    } catch(e){
      navigator.hideDialogLoading();
      navigator.showMessageSnackPar(message: e.toString());
    }
  }
  Future<void>resetPassword({required String email})async{
    navigator.showLoading();
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      navigator.hideDialogLoading();
      navigator.showMessageSnackPar(message: "A message has been sent to your account to change the password please go and change the password");
    } on Exception catch (_) {
      navigator.hideDialogLoading();
      navigator.showMessageSnackPar(message: "This email is not valid, modify it");
    }
  }
  Future<void>logout()async{
    navigator.showLoading();
    await FirebaseAuth.instance.signOut();
    navigator.hideDialogLoading();
  }
  void onPressedSuffixIcon(){
    isHidePassword = !isHidePassword;
    eyePassword = isHidePassword == true
        ? Icons.remove_red_eye
        : Icons.remove_red_eye_outlined;
    notifyListeners();
  }
}