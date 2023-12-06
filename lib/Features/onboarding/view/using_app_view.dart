import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_application/core/base/base_state.dart';

import '../view_model/using_app_view_model.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});
  static const routeName = "";
  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends BaseState<OnBoardingView,OnBoardingViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Expanded(child: Image.asset("assets/images/onboarding/onboaring_image.png")),
            Text("Organize your to make a productive day",style: Theme.of(context).textTheme.titleLarge,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text("completing the priority tasks or getting the results that can help you maove the project forwerd",style: Theme.of(context).textTheme.titleMedium?.copyWith(color:Colors.grey,fontWeight: FontWeight.w500),),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 48.0),
              child: AnimatedButton(pressEvent: () {  },
                color: const Color(0xff5D9CEC),
              text: "Let's Start",
                buttonTextStyle: Theme.of(context).textTheme.displayMedium,
              ),
            )
          ],
        ),
      )
    );
  }

  @override
  OnBoardingViewModel initViewModel() {
    return OnBoardingViewModel();
  }
}
