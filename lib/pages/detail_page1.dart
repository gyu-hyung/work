import 'package:flutter/material.dart';

class DetailPage1 extends StatelessWidget {
  const DetailPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildBackButton(context),
          _buildProfileIcon(context),
          _buildBottomDraggbleSheet(context),
          _bottomBanner(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      color: Colors.grey.shade300,
      width: double.infinity,
      height: double.infinity,
      child: const Center(
        child: Text('여기에 지도 및 캐릭터 UI 구성 예정'),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: 54,
      left: 16,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFD4D4D4),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildProfileIcon(BuildContext context) {
    return Positioned(
      top: 54,
      right: 16,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            color: Color(0xFF9969FF),
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.antiAlias,
          child: Transform.scale(
            scale: 1.3,
            child: Image.asset(
              'assets/icons/ic_marker.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomDraggbleSheet(BuildContext context) {
    return Positioned(
      left: 8,
      right: 8,
      bottom: 95,
      height: 380,
      child: Column(
        children: [
          Expanded(
            child: DraggableScrollableSheet(
              initialChildSize: 0.7,
              minChildSize: 0.5,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                      bottom: Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    children: const [],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomBanner() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 83,
      child: Container(
        height: 59,
        width: 350,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              width: 350,
              child: Image.asset(
                'assets/banners/banner1.png',
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}
