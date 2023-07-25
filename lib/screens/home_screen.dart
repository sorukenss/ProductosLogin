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

    if(productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
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
        backgroundColor: Color.fromRGBO(255, 147, 229,1),

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