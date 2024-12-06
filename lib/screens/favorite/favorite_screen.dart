import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_ecommerce/screens/favorite/components/body.dart';
import 'package:ui_ecommerce/state_managements/favorite_provider.dart';
class FavouriteScreen extends StatelessWidget {
  static String routeName = "/fav";
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const Body(),
    );
  }
  
  AppBar appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Column(
        children: [
          Text(
            "Your Favorites",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Consumer<FavouriteProvider>(
            builder: (context, favourite, child) => Text(
                "${favourite.favouritesProducts.length} items",
                style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}