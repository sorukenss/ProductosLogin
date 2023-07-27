
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';

class CheckAuthScreen extends StatelessWidget {
  static const String routeName = 'Check';
   
  const CheckAuthScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return  Scaffold(
      body: Center(
         child: FutureBuilder(
          future: authService.readToken(),
          builder: ((context, snapshot){

            if(snapshot.hasData)
            return Text('Espere');

            if(snapshot.hasData == ''){
              Future.microtask(() {
              Navigator.pushReplacement(context, PageRouteBuilder(
                pageBuilder: (_ , __ , ___) =>LoginScreen(),
                transitionDuration: Duration(seconds: 0),
              ));
             });
            }else{
              Future.microtask(() {
              Navigator.pushReplacement(context, PageRouteBuilder(
                pageBuilder: (_ , __ , ___) =>HomeScreen(),
                transitionDuration: Duration(seconds: 0),
              ));
             });
            }

            

            return Container();

          })
          ),
      ),
    );
  }
}