import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice01/constants.dart';

class HiteenBottomNavBar extends StatefulWidget {
  const HiteenBottomNavBar({super.key});

  @override
  State<HiteenBottomNavBar> createState() => _HiteenBottomNavBarState();
}

class _HiteenBottomNavBarState extends State<HiteenBottomNavBar> {
  int _selectedIndex = 2;

  final List<Widget> _pages = [
    const Center(child: Text('틴스토리')),
    const Center(child: Text('틴투표')),
    const Center(child: Text('틴나우')),
    const Center(child: Text('틴픽')),
    const Center(child: Text('틴플레이')),
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ConvexAppBar(
        style: TabStyle.react,
        // style: TabStyle.fixed,
        backgroundColor: Colors.white,
        activeColor: const Color(0XFF6A26FD),
        color: Colors.black87,
        initialActiveIndex: _selectedIndex,
        items: [
          TabItem(
            icon: SvgPicture.asset(
              'assets/icons/ic_menu_story.svg',
            ),
            title: '틴스토리',
            fontFamily: kPaperlogyFont,
          ),
          TabItem(
            icon: SvgPicture.asset(
              'assets/icons/ic_menu_vote.svg',
            ),
            title: '틴투표',
            fontFamily: kPaperlogyFont,
          ),
          TabItem(
            icon: SvgPicture.asset(
              'assets/icons/ic_menu_now_active.svg',
            ),
            title: '틴나우',
            fontFamily: kPaperlogyFont,
          ),
          TabItem(
            icon: SvgPicture.asset(
              'assets/icons/ic_menu_pick.svg',
            ),
            title: '틴픽',
            fontFamily: kPaperlogyFont,
          ),
          TabItem(
            icon: SvgPicture.asset(
              'assets/icons/ic_menu_play.svg',
            ),
            title: '틴플레이',
            fontFamily: kPaperlogyFont,
          ),
        ],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
