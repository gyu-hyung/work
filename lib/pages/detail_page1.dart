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
          _buildBottomDraggableSheet(context),
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


Widget _buildBottomDraggableSheet(BuildContext context) {
  return Positioned(
    left: 8,
    right: 8,
    bottom: 95,
    height: 390,
    child: DraggableScrollableSheet(
      snap: true,
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 3,
              ),
            ],
          ),
          child: Column(
            children: [
              // 드래그 핸들
              GestureDetector(
                onPanUpdate: (details) {
                  // 드래그 동작을 DraggableScrollableSheet에 전달
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
              // 실제 콘텐츠 영역
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    // 여기에 실제 콘텐츠를 추가하세요
                    Container(
                      height: 100,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text('콘텐츠 영역 1'),
                      ),
                    ),
                    Container(
                      height: 100,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text('콘텐츠 영역 2'),
                      ),
                    ),
                    Container(
                      height: 100,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text('콘텐츠 영역 3'),
                      ),
                    ),
                    // 더 많은 콘텐츠...
                  ],
                ),
              ),
            ],
          ),
        );
      },
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
