import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  static const String routeName = 'Home';
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductService>(context);
    final authService = Provider.of<AuthService>(context,listen: false);

    if(productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [
          IconButton(
           onPressed: ()
           {
              authService.logout();
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              

           }, icon: const Icon(Icons.login_outlined)),

            const SizedBox(width: 20,)
        ],
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: (BuildContext context, int index) =>  GestureDetector(
          onTap: () {
            productsService.selecProduct = productsService.products[index].copy();
            Navigator.pushNamed(context, ProductScreen.routeName);
          } ,
          child: ProductCard(
            product: productsService.products[index],
          ),

          ),
        ),
        backgroundColor: Colors.blue[100],

        floatingActionButton: FloatingActionButton(
          onPressed: (){
             productsService.selecProduct = new Product(
              available: true, name: '', price: 0
              );
            Navigator.pushNamed(context, ProductScreen.routeName);
          },
          child: const Icon(Icons.add),
          ),
    );
  }
}