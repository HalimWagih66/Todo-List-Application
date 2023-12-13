import 'package:flutter/material.dart';
import 'package:todo_list_application/Features/auth/model/info_user_model.dart';

class UserInformationProvider extends ChangeNotifier{
  late InformationUserModel _informationUserModel;
  late PageController pageController;
  UserInformationProvider(){
    pageController = PageController();
  }

  InformationUserModel get informationUserModel => _informationUserModel;

  set informationUserModel(InformationUserModel value) {
    _informationUserModel = value;
  }
}