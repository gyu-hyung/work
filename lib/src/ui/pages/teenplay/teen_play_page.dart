import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice01/constants.dart';
import 'package:practice01/src/ui/pages/teen_story/cubit/teen_story_cubit.dart';
import 'package:practice01/src/ui/widgets/avartar_stack.dart';
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
    return Scaffold(
      backgroundColor: const Color(0XffF6F6F6),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  _buildHiteenLogoAppBar(),
                  _buildButtonRow(),
                  _buildChallengeList(),
                  _buildLevelWithAvatars(),
                  _buildChallengeRows('assets/images/avartar01.png'),
                  _buildChallengeRows('assets/images/avartar02.png'),
                  _buildChallengeRows('assets/images/avartar03.png'),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBanner(),
    );
  }

  Widget _buildLevelWithAvatars() {
    final List<String> reactionAvatars = [
      'assets/icons/ic_marker1.png',
      'assets/icons/ic_marker2.png',
      'assets/icons/ic_marker3.png',
      'assets/icons/ic_marker4.png',
      'assets/icons/ic_marker5.png',
    ];
    const avatarSize = 20.0;
    const distance = 20.0;

    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 40, 20, 20),
      child: Row(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '단어암기',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: kPaperlogyFont),
              ),
              Text(
                'LEVEL 2',
                style: TextStyle(fontSize: 20, fontFamily: kDeBussyFont),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width:
                  (reactionAvatars.length + 2) * distance, // (아바타 수 + 마지막) * 간격
              height: avatarSize * 2,
              child: ReactionAvatarStack(
                reactionAvatars: reactionAvatars,
                avatarSize: avatarSize,
                distance: distance,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeRows(path) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: SizedBox(
            height: 80,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffF6F6F6),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Row(
                children: [
                  SizedBox(
                    width: 110,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Challenge',
                        style:
                            TextStyle(fontSize: 20, fontFamily: kDeBussyFont),
                      ),
                      Text(
                        'TITEEN',
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff212121),
                            fontFamily: kDeBussyFont),
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xff212121),
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 16,
          child: Image.asset(
            path,
            width: 110,
          ),
        ),
      ],
    );
  }

  Widget _buildChallengeItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
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
                              color: Color(0Xff212121),
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
      ),
    );
  }

  Widget _buildChallengeList() {
    return SizedBox(
      height: 300, // 카드 높이만큼 지정
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(width: 20),
          _buildChallengeItem(),
          _buildChallengeItem(),
          _buildChallengeItem(),
          _buildChallengeItem(),
          _buildChallengeItem(),
          _buildChallengeItem(),
        ],
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
