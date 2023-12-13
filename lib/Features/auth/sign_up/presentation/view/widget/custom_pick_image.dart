import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_application/Features/auth/sign_up/presentation/view_model/sign_up_view_model.dart';
import 'package:todo_list_application/core/style/colors/application_color.dart';

class CustomPickImage extends StatelessWidget {
  const CustomPickImage({super.key});
  @override
  Widget build(BuildContext context) {
    var providerSignUp = Provider.of<SignUpViewModel>(context);
    print("providerSignUp.pickImage ${providerSignUp.pickedImage}");
    return CircleAvatar(
      radius: 70,
      backgroundColor: providerSignUp.pickedImage != null?primaryColor:Colors.transparent,
      child: CircleAvatar(
        radius: 66,
        backgroundColor: const Color(0xfff7f6fa),
        backgroundImage: providerSignUp.pickedImage != null ? FileImage(providerSignUp.pickedImage!):null,
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: providerSignUp.pickedImage != null
                ? null
                : const Icon(
              Icons.person,
              size: 80,
              color: Colors.grey,
            ) ,),
      ),
    );
  }
}
