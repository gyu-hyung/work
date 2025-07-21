import 'package:flutter/material.dart';

class HiteenBottomBanner extends StatelessWidget {
  const HiteenBottomBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 83,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                width: 350,
                child: Image.asset(
                  'assets/images/banner1.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 32,
          child: Image.asset(
            'assets/icons/banner_close.png',
            width: 30,
            height: 16,
          ),
        ),
      ],
    );
  }
}
