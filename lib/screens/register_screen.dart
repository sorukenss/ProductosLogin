import 'package:flutter/material.dart';
import 'package:productos_app/providers/providers.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {

  static const String routeName = 'Register';
  const RegisterScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child:  Column(
            children: [
              const SizedBox(height: 250,),
              CardContainer(
                child: Column(
                  children: [
                     const SizedBox(height: 10,),
                     const Text('Crear Cuenta',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 30),),
                     const SizedBox(height: 30,),

                      ChangeNotifierProvider(
                        create: (_) => LoginFormProvider(),
                        child: _LoginForm(),
                        ),
                     

                  ],
                )
              ),
              const SizedBox(height: 100,),
               TextButton(onPressed: () => Navigator.pushReplacementNamed(context, LoginScreen.routeName),
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                shape: MaterialStateProperty.all(StadiumBorder()),
              ),
                child: const Text('Ya tienes una cuenta?',style: TextStyle(fontSize: 20, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 50,),
            ],
          ),
        )
      ),
    );
  }
}


class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
          key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(

              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.autInputDecoration(
                hintText: 'jhon@gmail.com', 
                labelText: 'Correo Electronico',
                 prefixIcon: Icons.alternate_email_sharp),
                 onChanged: (value) => loginForm.email=value,
                validator: (value){
                  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp  = new RegExp(pattern);
                  return regExp.hasMatch(value ?? '')
                         ? null 
                         :'El valor ingresado no cumple las condiciones de un correo';
                },
            ),
            const SizedBox(height: 30,),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.autInputDecoration(
                hintText: '********', 
                labelText: 'Contraseña', 
                prefixIcon: Icons.lock_outline_rounded),
                 onChanged: (value) => loginForm.password=value,
                validator: (value){
                  return (value!= null && value.length>=6) 
                  ? null 
                  : 'La contraseñan debe tener minimo 6 caracteres';
                },
            ),
             const SizedBox(height: 30,),

             MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child:  Text(
                  loginForm.isLoading
                  ?'Espere...'
                  :'Ingresar',
                   style: TextStyle(color: Colors.white),),
              ),

              onPressed: loginForm.isLoading? null :() async{
                FocusScope.of(context).unfocus();
                final authService = Provider.of<AuthService>(context, listen: false);
                if(!loginForm.isValidForm()) return;

                loginForm.isLoading=true;
                
               

                final String? errorMessage= await authService.createUser(loginForm.email, loginForm.password);

                if(errorMessage ==null){
                  
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                }else{
                  //TODO: mostrar error en pantalla
                  loginForm.isLoading=false;
                }

             })
          ],
          ),
        ),
    );
  }
}