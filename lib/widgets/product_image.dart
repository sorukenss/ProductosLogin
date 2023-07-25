
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? url;

  const ProductImage({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10,left: 10,top: 10),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: 450,
        child: Opacity(
          opacity: 0.9,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(30)),
            child: this.url == null 
            ?Image(image: AssetImage('assets/no-image.png'),
              fit: BoxFit.cover,
            )
            :FadeInImage(
              placeholder: const AssetImage('assets/jar-loading.gif') ,
               image: NetworkImage(url!),
               fit: BoxFit.cover,
               ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.black,
    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(30)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 5)

      ),
    ]
    
  );
}