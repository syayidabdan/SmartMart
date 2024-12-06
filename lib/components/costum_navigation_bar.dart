import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_ecommerce/constant.dart';
import 'package:ui_ecommerce/enums.dart';
import 'package:ui_ecommerce/screens/favorite/favorite_screen.dart';
import 'package:ui_ecommerce/screens/home/components/home_screen.dart';
import 'package:ui_ecommerce/screens/profile/profile_screen.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
    required this.menu,
  });

  final MenuState menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context,
            "assets/icons/Shop Icon.svg",
            MenuState.home,
          ),
          _buildNavItem(
            context,
            "assets/icons/Heart Icon.svg",
            MenuState.favorite,
          ),
          _buildFloatingButton(context),
          _buildNavItem(
            context,
            "assets/icons/User Icon.svg",
            MenuState.profile,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String asset, MenuState currentMenu) {
    final bool isSelected = menu == currentMenu;

    return GestureDetector(
      onTap: () {
        switch (currentMenu) {
          case MenuState.home:
            Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
            break;
          case MenuState.favorite:
            Navigator.pushNamed(context, FavouriteScreen.routeName);
            break;
          case MenuState.profile:
            Navigator.pushNamedAndRemoveUntil(context, ProfileScreen.routeName, (route) => false);
            break;
          default:
            break;
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? kPrimaryColor.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: SvgPicture.asset(
          asset,
          color: isSelected ? kPrimaryColor : Colors.grey,
          height: 24, // Konsisten ukuran ikon
          width: 24, // Konsisten ukuran ikon
        ),
      ),
    );
  }

  Widget _buildFloatingButton(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -10), // Sedikit floating
      child: GestureDetector(
        onTap: () {
          // Logika untuk tombol tengah (chat/message)
        },
        child: Container(
          height: 50, // Ukuran tombol tengah konsisten
          width: 50,  // Ukuran tombol tengah konsisten
          decoration: BoxDecoration(
            color: kPrimaryColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: kPrimaryColor.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: SvgPicture.asset(
              "assets/icons/Chat bubble Icon.svg",
              color: Colors.white,
              height: 24, // Konsisten ukuran ikon
              width: 24, // Konsisten ukuran ikon
            ),
          ),
        ),
      ),
    );
  }
}
