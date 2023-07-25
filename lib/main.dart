import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>  ProductService())

      ],
      child: MyApp(),
      );
  }
}

class MyApp extends StatelessWidget {
  final  Color colorPrimary = Colors.indigo;
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: HomeScreen.routeName,
      routes: {
        LoginScreen.routeName  : (_) => const  LoginScreen(),
        HomeScreen.routeName   : (_) => const  HomeScreen(),
        ProductScreen.routeName   : (_) => const  ProductScreen(),

      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[350],
        appBarTheme:  AppBarTheme(
          elevation: 0,
          color: colorPrimary,
        ),

        floatingActionButtonTheme:  FloatingActionButtonThemeData(
          backgroundColor: colorPrimary,
          elevation: 0,
        ),
      ),
    );
  }
}