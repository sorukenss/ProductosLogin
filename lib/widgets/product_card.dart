import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductCard extends StatelessWidget {

  final Product product;
   
  const ProductCard(
    {Key? key, required this.product}
  ) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardDecoration(),
        child: Stack(
                alignment: Alignment.bottomLeft,
              children: [
                  _BackgroundImage(urlImage: product.picture,),
                   _ProductDetails(title: product.name,idProduct: '${product.id}'),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: _PriceTag(price: product.price)
                    ),
                    if(!product.available)
                    Positioned(
                    top: 0,
                    left: 0,
                    child: _NotAvalible()
                    ),
                ]),
            ),
    );
  }

  BoxDecoration _cardDecoration() =>  BoxDecoration(
    color: Colors.grey[100],
    borderRadius: BorderRadius.circular(20),
    boxShadow:const  [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 7),
        blurRadius: 10,
      ),
    ],
  );
}

class _NotAvalible extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: const Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10),
          child: Text('No disponible',style: TextStyle(fontSize: 20,color: Colors.white),),
        ),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.yellow[800], 
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
        
        ),

    );
  }
}

class _PriceTag extends StatelessWidget {

  final double price;

  const _PriceTag({super.key, required this.price});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('\$$price',style: TextStyle(fontSize: 20,color: Colors.white),),
        ),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.indigo, 
        borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
        
        ),

    );
  }
}

class _ProductDetails extends StatelessWidget {
 final String title;
 final String idProduct;

  const _ProductDetails({super.key, required this.title, required this.idProduct});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
              maxLines: 1,overflow: TextOverflow.ellipsis,
              ),
               Text(
              idProduct,
              style: TextStyle(fontSize: 20,color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
      color: Colors.indigo,
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topRight: Radius.circular(20))
  );
}

class _BackgroundImage extends StatelessWidget {
  final String? urlImage;

  const _BackgroundImage({ this.urlImage});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        height: 400,
        child: urlImage ==null
        ?Image(image: AssetImage('assets/no-image.png'),
        fit: BoxFit.cover,
        )
        :FadeInImage(
          placeholder: const AssetImage('assets/jar-loading.gif'), 
          image: NetworkImage(urlImage!),
          fit: BoxFit.cover,
           ),
      ),
    );
  }
}