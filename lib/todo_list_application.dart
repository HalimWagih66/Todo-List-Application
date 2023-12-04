import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_list_application/Features/auth/continue_account/view/continue_account%20_view.dart';
import 'package:todo_list_application/Features/auth/login/view/login_view.dart';
import 'package:todo_list_application/core/style/theme.dart';
import 'Features/auth/sign_up/view/sign_up_view.dart';

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
        ContinueAccount.routeName:(context)=> const ContinueAccount(),
    },
      initialRoute: ContinueAccount.routeName,
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
