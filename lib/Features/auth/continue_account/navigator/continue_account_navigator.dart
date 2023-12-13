import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_application/core/base/base_navigator.dart';

abstract class ContinueAccountNavigator extends BaseNavigator{
  void initializeInformationUserModel(UserCredential userCredential);
  void connectEditPhoneNumber();
  void pushScreenSignUpAndRemoveUntil();
}
