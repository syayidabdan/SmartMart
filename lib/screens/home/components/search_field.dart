import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_ecommerce/constant.dart';
import 'package:ui_ecommerce/model/products.dart';
import 'package:ui_ecommerce/screens/details/detail_screen.dart';
import 'package:ui_ecommerce/size_config.dart';
import 'package:ui_ecommerce/state_managements/search_provider.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        width: SizeConfig.screenWidth * 0.6,
        decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          onChanged: (value) {
            Provider.of<SearchProvider>(context, listen: false)
                .updateSearchQuery(value, demoProducts);
            _updateOverlay(context); // Update overlay
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: getPropScreenWidth(20),
              vertical: getPropScreenWidth(9),
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search product",
            prefixIcon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }

  void _updateOverlay(BuildContext context) {
    _removeOverlay();
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);

    if (searchProvider.searchQuery.isNotEmpty &&
        searchProvider.filteredProducts.isNotEmpty) {
      _overlayEntry = _myOverlayEntry(context);
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  OverlayEntry _myOverlayEntry(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);

    return OverlayEntry(
      builder: (context) => Positioned(
        width: SizeConfig.screenWidth * 0.6,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(-10, getPropScreenWidth(60)),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(15),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: searchProvider.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = searchProvider.filteredProducts[index];
                  final query = searchProvider.searchQuery.toLowerCase();
                  final matchIndex = product.title.toLowerCase().indexOf(query);
                  final matchedText = product.title.substring(
                    matchIndex,
                    matchIndex + query.length,
                  );
                  final remainingText =
                      product.title.replaceFirst(matchedText, '');
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DetailScreen.routeName,
                          arguments: product,
                        );
                        searchProvider.clearSearch();
                        _removeOverlay();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                product.images[0],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: matchedText,
                                          style: const TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: remainingText,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "\$${product.price.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.favorite_border,
                                color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }
}
