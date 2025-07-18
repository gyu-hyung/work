import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice01/constants.dart';
import 'package:practice01/src/ui/pages/teen_story/cubit/teen_story_cubit.dart';
import 'package:practice01/src/ui/pages/teen_story/widgets/feed_item.dart';
import 'package:practice01/src/ui/widgets/hiteen_bottom_banner.dart';
import 'package:practice01/src/ui/widgets/hiteen_logo_app_bar.dart';

class TeenPlayPage extends StatelessWidget {
  const TeenPlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TeenPlayPageView();
  }
}

class TeenPlayPageView extends StatelessWidget {
  const TeenPlayPageView({super.key});

  Widget _buildHiteenLogoAppBar() {
    return const HiteenLogoAppBar();
  }

  Widget _buildBottomBanner() {
    return const HiteenBottomBanner();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0XffF6F6F6),
      body: Container(
        height: screenHeight * 0.55,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Column(
          children: [
            _buildHiteenLogoAppBar(),
            _buildButtonRow(),
            _buildChallengeList(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBanner(),
    );
  }

  Widget _buildChallengeItem() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
          child: SizedBox(
            width: 190,
            height: 200,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0XFFF6F6F6),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Challenge',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: kDeBussyFont,
                            fontWeight: FontWeight.w500),
                      ),
                      const Text(
                        'HITEEN',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: kDeBussyFont,
                            color: Color(0Xff2121214d),
                            fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '64%',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: kDeBussyFont,
                                  fontWeight: FontWeight.w500),
                            ),
                            SvgPicture.asset(
                              'assets/icons/ic_heart.svg',
                              width: 30,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 25,
          child: Image.asset(
            'assets/images/ic_darcy_avartar1.png',
            width: 139,
          ),
        )
      ],
    );
  }

  Widget _buildChallengeList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 300, // 카드 높이만큼 지정
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _buildChallengeItem(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: _roundedElevatedButton(
                '도전하기', 'assets/icons/ic_star.svg', true,
                onPressed: () {}),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: _roundedElevatedButton(
                '도전하기', 'assets/icons/ic_thunder.svg', false,
                onPressed: () {}),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: _roundedElevatedButton(
                '도전하기', 'assets/icons/ic_thunder.svg', false,
                onPressed: () {}),
          ),
        ],
      ),
    );
  }

  Widget _roundedElevatedButton(String text, String path, bool isSelected,
      {VoidCallback? onPressed}) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isSelected
              ? const Color(0xFF6A26FD)
              : const Color(0xFFF8F8F8), // 기존 색상과 동일
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          padding: EdgeInsets.zero, // 내부 여백 최소화
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              path,
              width: 13,
              height: 13,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
                fontFamily: kPaperlogyFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
