import 'package:flutter/material.dart';
import 'package:productos_app/widgets/widgets.dart';

import '../ui/input_decorations.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = 'Product';
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ProductImage(),
                  Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                      onPressed: ()=> Navigator.of(context).pop(),
                       icon: Icon(Icons.arrow_back_ios_new, size: 40, color: Colors.white,)
                       ), 
                    ),
                    Positioned(
                    top: 60,
                    right: 30,
                    child: IconButton(
                      onPressed: (){
                        //camara o galeria
                      },
                       icon: Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white,)
                       ), 
                    ),
                ],
              ),
              _ProductForm(),
    
              const SizedBox(height: 100,)
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save_outlined),
          onPressed: (){
            //guardar producto
          }),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        height: 300,
        decoration: _buildDecorationProduct(),
        child: Form(
          child: Column(
            children: [

              const SizedBox(height: 10,),
              
              TextFormField(
               
                decoration: InputDecorations.autInputDecoration(
                  hintText: 'Nombre Del Producto',
                   labelText: 'Nombre: ',
                   ),

              ),
              const SizedBox(height: 30,),

               TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecorations.autInputDecoration(
                  hintText: '\$150',
                   labelText: 'Precio: ',
                   ),

              ),

              const SizedBox(height: 30,),

              SwitchListTile.adaptive(
                value: true,
                title: const Text('Disponible'),
                activeColor: Colors.indigo,
                 onChanged: (value){
                  // habilitado o desabilitado el producto
                 }),

              const SizedBox(height: 30,)
            ],
          ),
          ),
    
      ),
    );
  }

  BoxDecoration _buildDecorationProduct() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 5,
        offset: Offset(0, 5)
      ),
    ]
  );
}