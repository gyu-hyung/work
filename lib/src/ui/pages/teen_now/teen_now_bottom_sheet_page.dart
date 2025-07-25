import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice01/constants.dart';
import 'package:practice01/src/data/models/teen_friend.dart';
import 'package:practice01/src/ui/pages/teen_now/cubit/teen_now_cubit.dart';
import 'package:practice01/src/ui/pages/teen_now/cubit/teen_now_state.dart';

class TeenNowBottomSheetPage extends StatelessWidget {
  const TeenNowBottomSheetPage({
    super.key,
    required this.minBound,
    required this.sheetHeight,
    required this.scrollController,
  });

  final double minBound;
  final ValueNotifier<double> sheetHeight;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        color: Colors.white,
        shadows: [
          BoxShadow(
            blurRadius: 5.0,
            spreadRadius: 2.0,
            color: Color(0x11000000),
          )
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28.0),
            topRight: Radius.circular(28.0),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDragHandle(),
          ValueListenableBuilder<double>(
            valueListenable: sheetHeight,
            builder: (context, value, child) {
              return AnimatedCrossFade(
                duration: const Duration(milliseconds: 150),
                crossFadeState: value <= minBound
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: _buildProfileSection(),
                secondChild: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Column(
                    children: [
                      _buildCountWithAddFriends(),
                      Expanded(
                        child: _buildFriendList(),
                      ),
                    ],
                  ),
                ),
                firstCurve: Curves.easeIn,
                secondCurve: Curves.easeOut,
                sizeCurve: Curves.easeInOut,
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildDragHandle() {
    return Container(
      alignment: Alignment.center,
      height: 30.0,
      child: Container(
        width: 50,
        height: 5,
        decoration: BoxDecoration(
          color: const Color(0xffDDDDDD),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 16, 22, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: Color(0xFF9969FF),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Transform.scale(
              scale: 1.3,
              child: Image.asset(
                'assets/images/ic_darcy_avartar1.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                decoration: ShapeDecoration(
                  color: const Color(0xffF2F2F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Text(
                      '😍 오늘도 맑음',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '강윤슬(눈물의달력)',
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: kPaperlogyFont,
                    fontWeight: FontWeight.w500),
              ),
              const Text(
                '광주 북구 오룡동',
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: kPaperlogyFont,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff949494)),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: 47,
            height: 24,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                side: const BorderSide(color: Colors.black, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
              ),
              onPressed: () {},
              child: const Text(
                '프로필',
                style: TextStyle(
                  fontFamily: kPaperlogyFont,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCountWithAddFriends() {
    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          height: 42,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(
                children: [
                  Text(
                    '😊',
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(width: 6),
                  Text(
                    '친구 53',
                    style: TextStyle(
                      fontFamily: kPaperlogyFont,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: 77,
                height: 30,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xff1947E5),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        size: 12,
                        color: Colors.white,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '친구추가',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontFamily: kPaperlogyFont,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1.0),
      ],
    );
  }

  Widget _buildFriendList() {
    return BlocBuilder<TeenNowCubit, TeenNowState>(
      builder: (context, state) {
        final friends = state.friendList;
        return ListView.separated(
          padding: const EdgeInsets.only(bottom: 16),
          controller: scrollController,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return _buildFriendListItem(friends[index]);
          },
          separatorBuilder: (context, index) {
            return const Divider(height: 0.5);
          },
          itemCount: friends.length,
        );
      },
    );
  }

  Widget _buildFriendListItem(TeenNowFriend friend) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: Color(0xFF9969FF),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Transform.scale(
              scale: 1.3,
              child: Image.asset(
                friend.profileImageUrl,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                friend.nickname,
                style: const TextStyle(
                  fontFamily: kPaperlogyFont,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                friend.mood,
                style: const TextStyle(
                  fontFamily: kPaperlogyFont,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff949494),
                ),
              ),
              Text(
                friend.address,
                style: const TextStyle(
                  fontFamily: kPaperlogyFont,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff949494),
                ),
              ),
            ],
          ),
          const Spacer(),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              side: const BorderSide(color: Colors.black, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            onPressed: () {},
            child: const Text(
              '프로필',
              style: TextStyle(
                fontFamily: kPaperlogyFont,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
