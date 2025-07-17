import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice01/src/ui/widgets/hiteen_bottom_banner.dart';
import 'package:practice01/src/ui/widgets/hiteen_logo_app_bar.dart';

class TeenStoryTimeLinePage extends StatelessWidget {
  final String userId;

  const TeenStoryTimeLinePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return TeenStoryTimeLinePageView(userId: userId);
  }
}

class TeenStoryTimeLinePageView extends StatelessWidget {
  final String userId;

  const TeenStoryTimeLinePageView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHiteenLogoAppBar(),
                const SizedBox(height: 16),
                _buildProfileSection(),
                const SizedBox(height: 15),
                _buildButtonRow(),
                const SizedBox(height: 26),
                _buildIconRow(),
                const SizedBox(height: 30),
                _buildGridSection(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBanner(),
    );
  }

  Widget _buildHiteenLogoAppBar() => const HiteenLogoAppBar();
  Widget _buildBottomBanner() => const HiteenBottomBanner();

  // 1. 상단 프로필/정보/통계
  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 네모에 radius 16 적용
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Container(
              color: const Color(0XffCFA8FF),
              child: Image.asset(
                'assets/images/ic_darcy_avartar1.png',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 24),
          // 이름, 학교, 반, 통계
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '박수빈',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  '하이틴 고등학교 3학년 7반',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 13),
                // 좋아요/댓글/조회수 Row - 좌우 공간 가득
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatsRow(
                        icon: Icons.thumb_up_alt_outlined, count: '421796'),
                    _buildStatsRow(
                        icon: Icons.chat_bubble_outline, count: '58932'),
                    _buildStatsRow(
                        icon: Icons.remove_red_eye_outlined, count: '7865'),
                    const SizedBox(height: 0),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// 2. 버튼 Row: flex로 3:3:1
  Widget _buildButtonRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: _roundedElevatedButton('버튼', onPressed: () {
              print('첫 번째 버튼 클릭');
            }),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: _roundedElevatedButton('버튼', onPressed: () {
              print('두 번째 버튼 클릭');
            }),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: _roundedElevatedButton('버튼', onPressed: () {
              print('세 번째 버튼 클릭');
            }),
          ),
        ],
      ),
    );
  }

// ElevatedButton 커스텀 스타일
  Widget _roundedElevatedButton(String text, {VoidCallback? onPressed}) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xFFF8F8F8), // 기존 색상과 동일
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.zero, // 내부 여백 최소화
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  // 3. 아이콘 Row: spaceBetween으로 양끝까지 꽉차게
  Widget _buildIconRow() {
    final icons = [
      'assets/icons/menu_101_off1.svg',
      'assets/icons/menu_101_off2.svg',
      'assets/icons/menu_101_off3.svg',
      'assets/icons/menu_101_off4.svg',
      'assets/icons/menu_101_off5.svg',
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: icons
            .map(
              (icon) => IconButton(
                icon: SvgPicture.asset(icon, width: 40, height: 28),
                onPressed: () {},
                splashRadius: 24,
              ),
            )
            .toList(),
      ),
    );
  }

  // 4. 좋아요/댓글/조회수 위젯 (파라미터 활용)
  Widget _buildStatsRow({required IconData icon, required String count}) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[700]),
        const SizedBox(width: 4),
        Text(count,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildGridSection() {
    final heights = [
      180.0,
      100.0,
      140.0,
      120.0,
      180.0,
      140.0,
      100.0,
      140.0,
      120.0,
      140.0,
      120.0,
      100.0
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MasonryGridView.count(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemCount: 24,
        itemBuilder: (context, index) {
          return Container(
            height: heights[index % heights.length],
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(18),
            ),
          );
        },
      ),
    );
  }
}
