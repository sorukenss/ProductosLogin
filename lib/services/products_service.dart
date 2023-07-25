import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;


class ProductService extends ChangeNotifier{

  final String _baseUrl = 'flutter-varios-90b0e-default-rtdb.firebaseio.com';
  final List<Product> products=[];
  Product? selecProduct;

  bool isLoading = true;
  bool isSaving = false;

  ProductService(){
    this.loadProducts();
  }


  Future<List<Product>> loadProducts() async{

    this.isLoading= true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);
    
    final Map<String, dynamic>  productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
        final productsTemp = Product.fromRawJson(json.encode(value));
        productsTemp.id = key;
        this.products.add(productsTemp);
    });

    this.isLoading= false;
    notifyListeners();
    
      return this.products;
  }


  Future saveOrCreateProduct(Product product) async{

    isSaving= true;
    notifyListeners();
      if(product.id==null){
        await this.createProduct(product);
      }else{
        await this.updateProduct(product);
      }





    isSaving = false;
    notifyListeners();
  }
  

  Future<String> updateProduct(Product product) async{

      final url = Uri.https(_baseUrl, 'products/${product.id}.json');
      final resp = await http.put(url, body: product.toRawJson());
      final decodeData = resp.body;

      final index= this.products.indexWhere((element) => element.id == product.id);
      this.products[index] = product;
      
      return product.id!;

  }


  Future<String> createProduct(Product product) async{

      final url = Uri.https(_baseUrl, 'products.json');
      final resp = await http.post(url, body: product.toRawJson());
      final decodeData = json.decode(resp.body);

      product.id = decodeData['name'];


      this.products.add(product);
      return product.id!;

  }

}