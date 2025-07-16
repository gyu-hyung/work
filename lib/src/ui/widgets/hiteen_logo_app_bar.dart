import 'package:flutter/material.dart';

class HiteenLogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HiteenLogoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Image.asset(
        'assets/icons/hiteen_logo.png',
        fit: BoxFit.cover,
        width: 100,
        height: 22,
        alignment: Alignment.topCenter,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
