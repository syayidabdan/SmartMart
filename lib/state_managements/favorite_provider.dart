import 'package:flutter/material.dart';
import 'package:ui_ecommerce/model/products.dart';

class FavouriteProvider extends ChangeNotifier {
  final List<Product> _listProducts = demoProducts;

  List<Product> get favouritesProducts {
    return _listProducts.where((product) => product.isFavourite).toList();
  }

  void toogleFavouriteStatus(int id){
    final productIndex = _listProducts.indexWhere((product) => product.id == id);
    _listProducts[productIndex].isFavourite =
     !_listProducts[productIndex].isFavourite;
    notifyListeners();
  }

  List<Product> get listProducts => _listProducts;
}