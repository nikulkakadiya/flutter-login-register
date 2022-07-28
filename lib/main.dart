import 'package:flutter/material.dart';
import 'package:login_register/screens/home_screen.dart';

import 'package:login_register/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//
//   runApp(const MyApp());
//   // runApp(MaterialApp(home: token!=''?HomeScreen():LoginScreen()));
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print('email id print ${email} you');
  runApp(MaterialApp(home: email==null?LoginScreen():HomeScreen()));
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Email And Password Login',
      theme: ThemeData(

        primarySwatch: Colors.red,
      ),
      home: const LoginScreen(),
    );
  }
}

