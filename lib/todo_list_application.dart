import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_list_application/Features/auth/login/view/login_view.dart';
import 'package:todo_list_application/Features/home%20layout/view/home_layout_view.dart';
import 'package:todo_list_application/Features/onboarding/view/using_app_view.dart';
import 'package:todo_list_application/core/style/theme/theme.dart';

import 'Features/auth/continue_account/view/continue_account_view.dart';
import 'Features/auth/continue_account_with_email/view/continue_with_email_view.dart';
import 'Features/auth/sign_up/presentation/view/sign_up_view.dart';

class TodoListApplication extends StatelessWidget {
  const TodoListApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todo List",
      routes: {
        SignUpView.routeName:(context)=>const SignUpView(),
        LoginView.routeName:(context)=> const LoginView(),
        ContinueAccountView.routeName:(context)=> const ContinueAccountView(),
        OnBoardingView.routeName:(context)=> const OnBoardingView(),
        HomeLayout.routeName:(context)=> const HomeLayout(),
        ContinueAccountWithEmailView.routeName:(context)=> const ContinueAccountWithEmailView()
    },
      initialRoute: ContinueAccountView.routeName,
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeApp.lightTheme,
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Spanish
      ],
    );
  }
}
