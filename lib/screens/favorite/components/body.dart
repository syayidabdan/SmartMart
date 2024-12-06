import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:ui_ecommerce/constant.dart';
import 'package:ui_ecommerce/model/cart.dart';
import 'package:ui_ecommerce/model/products.dart';
import 'package:ui_ecommerce/size_config.dart';
import 'package:ui_ecommerce/state_managements/cart_provider.dart';
import 'package:ui_ecommerce/state_managements/favorite_provider.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavouriteProvider>(
      builder: (context, favourite, child) => ListView.builder(
          itemCount: favourite.favouritesProducts.length,
          itemBuilder: (context, index) {
            final Product product = favourite.favouritesProducts[index];
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getPropScreenWidth(20),
                vertical: getPropScreenWidth(10),
              ),
              child: Slidable(
                key: Key(product.id.toString()),
                endActionPane:
                    ActionPane(motion: const ScrollMotion(), children: [
                  SlidableAction(
                    onPressed: (context) {
                      Provider.of<CartProvider>(context, listen: false)
                          .addCartItem(
                        Cart(product: product, numOfItem: 1),
                      );
                      favourite.toogleFavouriteStatus(product.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Added to cart'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: Icons.shopping_cart,
                    label: 'Cart',
                    padding: EdgeInsets.all(getPropScreenWidth(10)),
                    backgroundColor: kPrimaryColor,
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      favourite.toogleFavouriteStatus(product.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Removed from favourite'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: Icons.delete,
                    label: 'Delete',
                    padding: EdgeInsets.all(getPropScreenWidth(10)),
                    backgroundColor: Colors.red,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: getPropScreenWidth(88),
                      child: AspectRatio(
                        aspectRatio: 0.88,
                        child: Container(
                          padding: EdgeInsets.all(getPropScreenWidth(20)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: kSecondaryColor.withOpacity(0.2)),
                          child: Image.asset(
                            product.images[0],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          // style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: "\$${product.price}",
                            style: TextStyle(
                                fontSize: getPropScreenWidth(14),
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor),
                          ),
                        ])),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}