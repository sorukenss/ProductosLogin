import 'package:flutter/material.dart';


class LoadingScreen extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: Center(
         child: CircularProgressIndicator(
          color: Colors.indigo,
         ),
      ),
    );
  }
}