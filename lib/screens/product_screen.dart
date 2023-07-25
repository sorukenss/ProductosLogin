import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:productos_app/providers/providers.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../ui/input_decorations.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = 'Product';
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selecProduct!),
      child: _ProductScreensBody(productService: productService),
      );
  }
}

class _ProductScreensBody extends StatelessWidget {
  const _ProductScreensBody({
    super.key,
    required this.productService,
  });

  final ProductService productService;

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
         // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              Stack(
                children: [
                  ProductImage(url: productService.selecProduct?.picture),
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
                      onPressed: () async{
                        final picker = new ImagePicker();
                        final XFile? pickedFile = await picker.pickImage(
                              source: ImageSource.camera,
                              imageQuality: 100  
                      );

                        if(pickedFile == null){
                          print('No selecciono nada');
                          return;
                        }

                        productService.updateSelectedProductImage(pickedFile.path);

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
          child: productService.isSaving
          ? CircularProgressIndicator(color: Colors.white)
          :Icon(Icons.save_outlined),
          onPressed: productService.isSaving
          ?null
          : () async{
            if(!productForm.isValidForm()) return;

            final String? imageUrl = await productService.uploadImage();
            
            if(imageUrl != null) productForm.product.picture = imageUrl;

            await productService.saveOrCreateProduct(productForm.product);
          }),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        height: 300,
        decoration: _buildDecorationProduct(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10,),
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value){
                  if(value == null || value.length<1)
                  return 'El nombre es obligatorio';
                },
                decoration: InputDecorations.autInputDecoration(
                  hintText: 'Nombre Del Producto',
                   labelText: 'Nombre: ',
                   ),

              ),
              const SizedBox(height: 30,),

               TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  double.tryParse(value) ==null
                  ?product.price=0
                  :product.price=double.parse(value);
                   
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.autInputDecoration(
                  hintText: '\$150',
                   labelText: 'Precio: ',
                   ),

              ),

              const SizedBox(height: 30,),

              SwitchListTile.adaptive(
                value: product.available,
                title: const Text('Disponible'),
                activeColor: Colors.indigo,
                 onChanged: (value) => productForm.updateAvailability(value)
                 ),

              const SizedBox(height: 30)
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