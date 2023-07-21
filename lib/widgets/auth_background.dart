import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  
  final Widget child;
  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),

          const _HeaderIcon(),

          this.child,
        ]
    ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        width: double.infinity,
        child: const Icon(Icons.person_pin, color: Colors.white,size: 100,),
      ),
    );
  }
}

// ignore: unused_element
class _PurpleBox extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height*0.4,
      decoration: _PurpleBackground(),
      child: Stack(
        children: [
            Positioned(child: _Bubble(),top: 90,left: 20,),
            Positioned(child: _Bubble(),top: -40,left: 40,),
            Positioned(child: _Bubble(),bottom: -40,right: 20,),
            Positioned(child: _Bubble(),bottom: 90,right: 30,),
            Positioned(child: _Bubble(),top: 120,right: 10,),
            Positioned(child: _Bubble(),bottom: 70,left: 10,),
        ]
      ),
    );
  }

  BoxDecoration _PurpleBackground() => BoxDecoration(
    gradient:  LinearGradient(
      colors:  [
         Color.fromRGBO(63, 63, 156, 1),
         Color.fromRGBO(90, 70, 178, 1),

      ]
      )
  );
}

class _Bubble extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05)
        ),
    );
  }
}