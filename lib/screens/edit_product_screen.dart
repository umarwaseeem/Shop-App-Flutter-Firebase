import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  static const routeName = "edit product screen";

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();

  var _editedProduct = Product(
    id: "",
    title: "",
    price: 0,
    description: "",
    imageUrl: "",
  );

  var _defaultValues = {
    "title": "",
    "description": "",
    "price": "",
    "imageUrl": ""
  };

  @override
  void dispose() {
    // dispose focus nodes to avoid memory leak
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imageUrlController.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      String prodId = ModalRoute.of(context)?.settings.arguments as String;

      // if(prodId != null){

      // }

      _editedProduct =
          Provider.of<Products>(context, listen: false).findByID(prodId);

      _defaultValues = {
        "title": _editedProduct.title,
        "description": _editedProduct.description,
        "price": _editedProduct.price.toString(),
        "imageUrl": "",
      };

      _imageUrlController.text = _editedProduct.imageUrl;
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  void initState() {
    _imageUrlController.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith("http") &&
              !_imageUrlController.text.startsWith("https")) ||
          (!_imageUrlController.text.endsWith(".jpg") &&
              !_imageUrlController.text.endsWith(".png") &&
              !_imageUrlController.text.endsWith(".jpeg"))) {
        return;
      }
      setState(() {});
    }
  }

  void _submitForm() {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    // ignore: unnecessary_null_comparison
    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {}

    _form.currentState!.save();

    Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(Icons.save),
          ),
        ],
        title: const Text("Edit Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _defaultValues["title"],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "The Title Cannot Be Empty";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Product Title",
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (var value) {
                  _editedProduct = Product(
                    title: value.toString(),
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                    id: _editedProduct.id,
                    isFavourite: _editedProduct.isFavourite,
                  );
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _defaultValues["price"],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Price Cannot be Empty";
                  }
                  if (double.tryParse(value) == null) {
                    return "Please enter a valid number";
                  }
                  if (double.parse(value) < 0) {
                    return "Price Cannot be less than zero";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Product Price",
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onSaved: (var value) {
                  _editedProduct = Product(
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: double.parse(value!),
                    imageUrl: _editedProduct.imageUrl,
                    id: _editedProduct.id,
                    isFavourite: _editedProduct.isFavourite,
                  );
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _defaultValues["description"],
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Product Description",
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descFocusNode);
                },
                onSaved: (var value) {
                  _editedProduct = Product(
                    id: "",
                    title: _editedProduct.title,
                    description: value.toString(),
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 10, right: 12),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: Container(
                      child: _imageUrlController.text.isEmpty
                          ? const Text("Enter A Url")
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Url Cannot Be Empty 😑";
                        }
                        if (!value.startsWith("http") &&
                            !value.startsWith("https")) {
                          return "Url should start with http or https!";
                        }
                        if (!Uri.tryParse(value)!.hasAbsolutePath) {
                          return "This is not a valid url";
                        }
                        if (!value.endsWith(".jpg") &&
                            !value.endsWith(".png") &&
                            !value.endsWith(".jpeg")) {
                          return "This is not an image url";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Image Url",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) => _submitForm(),
                      onSaved: (var value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: value.toString(),
                          id: _editedProduct.id,
                          isFavourite: _editedProduct.isFavourite,
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
