import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName  : (_) => const  LoginScreen(),
        HomeScreen.routeName   : (_) => const  HomeScreen(),

      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[350],
      ),
    );
  }
}