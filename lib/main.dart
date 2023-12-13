import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_application/provider/edit_phone_number_provider.dart';
import 'package:todo_list_application/provider/user_information_provider.dart';
import 'package:todo_list_application/todo_list_application.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) =>UserInformationProvider()),
      Provider(create: (context) => EditPhoneNumberProvider())
    ],
  child: const TodoListApplication()));
}

