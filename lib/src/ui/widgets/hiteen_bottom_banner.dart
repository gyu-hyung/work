import 'package:flutter/material.dart';

class HiteenBottomBanner extends StatelessWidget {
  const HiteenBottomBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 83,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            width: 350,
            child: Image.asset(
              'assets/banners/banner1.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
