import 'package:flutter/material.dart';

class InputDecorations {

 static InputDecoration autInputDecoration({
  required String hintText,
  required String labelText,
  IconData? prefixIcon,
 }){

  return  InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 2,
                  ),
                ),
                hintText: hintText,
                labelText: labelText,
                labelStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(prefixIcon,color: Colors.deepPurple,)
              );
 }
}