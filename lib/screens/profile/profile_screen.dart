import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_ecommerce/components/costum_navigation_bar.dart';
import 'package:ui_ecommerce/enums.dart';
import 'package:ui_ecommerce/screens/profile/components/body.dart';
import 'package:ui_ecommerce/state_managements/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const Body(),
      bottomNavigationBar: const CustomNavigationBar(menu: MenuState.profile),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        "Profile",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        Consumer<ThemeProvider>(
          builder: (context, theme, child) => IconButton(
            icon: Icon(
                theme.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                color: Theme.of(context).iconTheme.color),
            onPressed: () {
              theme.toogleTheme(!theme.isDarkMode);
            },
          ),
        ),
      ],
    );
  }
}
