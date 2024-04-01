import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/register_controller.dart';
import 'package:flutter_application_1/view/register.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterController(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: RegisterScreen(),
      ),
    );
  }
}
