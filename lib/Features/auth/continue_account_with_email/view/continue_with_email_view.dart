import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_application/Features/auth/login/view/login_view.dart';
import 'package:todo_list_application/Features/auth/sign_up/presentation/view/sign_up_view.dart';
import 'package:todo_list_application/core/style/colors/application_color.dart';

import '../../continue_account/view/continue_account_view.dart';
import '../../sign_up/presentation/view/widget/custom_leading_item.dart';

class ContinueAccountWithEmailView extends StatelessWidget {
  const ContinueAccountWithEmailView({super.key});
  static String routeName = "ContinueAccountWithEmailView";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomLeadingItem(colorIcon: primaryColor, onPressed:(){
          Navigator.pushReplacementNamed(context, ContinueAccountView.routeName);
        },),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/auth/continue_account_with_email/continue_account_email_image.png"),
            Text("Task Management",style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Text("Time is The scarcest resource and unless it is managed nothing else can be managed",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
            const SizedBox(height: 20),

            AnimatedButton(pressEvent: (){
              Navigator.pushNamed(context, LoginView.routeName);
            },text: "Log in",color: primaryColor,buttonTextStyle:Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 10),
            AnimatedButton(pressEvent: (){
              Navigator.pushNamed(context, SignUpView.routeName);
            },text: "Sign Up",color: primaryColor,buttonTextStyle: Theme.of(context).textTheme.displayMedium),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),

          ],
        ),
      ),
    );
  }
}
