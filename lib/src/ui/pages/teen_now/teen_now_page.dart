import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:practice01/constants.dart';
import 'package:practice01/src/ui/pages/teen_now/bloc/expanded_bloc.dart';
import 'package:practice01/src/ui/widgets/hiteen_bottom_banner.dart';
import 'package:practice01/src/ui/widgets/hiteen_bottom_nav_bar.dart';

class TeenNowPage extends StatelessWidget {
  const TeenNowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmojiBloc(),
      child: const TeenNowPageView(),
    );
  }
}

class TeenNowPageView extends StatefulWidget {
  const TeenNowPageView({super.key});

  @override
  State<TeenNowPageView> createState() => _TeenNowPageViewState();
}

class _TeenNowPageViewState extends State<TeenNowPageView> {
  late final SlidingUpPanelController panelController;
  late final ScrollController scrollController;
  //floating buttons
  late final ValueNotifier<double> _sheetHeight;
  final double panelOpenHeight = 440.0;
  final double panelCloseHeight = 150.0;

  double anchor = 0.2;
  double minBound = 0;
  double upperBound = 1.0;

  @override
  void dispose() {
    panelController.dispose();
    scrollController.dispose();
    _sheetHeight.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _sheetHeight = ValueNotifier(0.0);
    panelController = SlidingUpPanelController();
    scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          upperBound = 0.6;
          minBound = 0.2;
          anchor = 0.2;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                _buildBackground(),
                _buildFloatingLogo(context),
                _buildFloatingButtons(),
                _buildBottomDragSheet(),
              ],
            ),
          ),
          const HiteenBottomNavBar(),
        ],
      ),
      bottomNavigationBar: const HiteenBottomBanner(),
    );
  }

  Widget _buildBackground() {
    return Container(
      color: Colors.grey.shade300,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: panelController.collapse,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                    ),
                    icon: SvgPicture.asset('assets/icons/ic_float_1.svg')),
                IconButton(
                    onPressed: panelController.hide,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                    ),
                    icon: SvgPicture.asset('assets/icons/ic_float_3.svg')),
              ],
            ),
            const Text('여기에 지도 및 캐릭터 UI 구성 예정'),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingLogo(BuildContext context) {
    return Positioned(
      top: 54,
      left: 16,
      child: GestureDetector(
        onTap: () => context.go('/'),
        child: SizedBox(
          width: 44,
          height: 44,
          child: Image.asset('assets/icons/hiteen_logo2.png'),
        ),
      ),
    );
  }

  Widget _buildFloatingButtons() {
    return ValueListenableBuilder<double>(
      valueListenable: _sheetHeight,
      builder: (context, value, child) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          bottom: value + 16.0,
          right: 16,
          child: Column(
            children: [
              IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                  ),
                  icon: SvgPicture.asset('assets/icons/ic_float_1.svg')),
              IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                  ),
                  icon: SvgPicture.asset('assets/icons/ic_float_2.svg')),
              IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                  ),
                  icon: SvgPicture.asset('assets/icons/ic_float_3.svg')),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomDragSheet() {
    return SlidingUpPanelWidget(
      controlHeight: 10.0,
      enableOnTap: false,
      panelController: panelController,
      panelStatus: SlidingUpPanelStatus.hidden,
      anchor: anchor,
      minimumBound: minBound,
      upperBound: upperBound,
      //드래그로 시트 hide
      dragEnd: (details) {
        final velocity = details.velocity.pixelsPerSecond.dy;

        if (velocity <= 100.0) {
          if (panelController.status == SlidingUpPanelStatus.collapsed) {
            panelController.hide();
          }
        }
      },
      onStatusChanged: (details) => {
        if (panelController.status != SlidingUpPanelStatus.dragging)
          {
            if (panelController.status == SlidingUpPanelStatus.expanded)
              {_sheetHeight.value = panelOpenHeight}
            else if (panelController.status == SlidingUpPanelStatus.anchored ||
                panelController.status == SlidingUpPanelStatus.collapsed)
              {_sheetHeight.value = panelCloseHeight}
            else
              {_sheetHeight.value = 0.0}
          }
      },
      child: Container(
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
              valueListenable: _sheetHeight,
              builder: (context, value, child) {
                return AnimatedCrossFade(
                  duration: const Duration(milliseconds: 150),
                  crossFadeState: value > panelCloseHeight
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: SizedBox(
                    height: 600, // 원하는 패널 최대 높이
                    child: Column(
                      children: [
                        _buildCountWithAddFriends(),
                        Expanded(child: _buildFriendList()),
                      ],
                    ),
                  ),
                  secondChild: _buildProfileSection(),
                  firstCurve: Curves.easeIn,
                  secondCurve: Curves.easeOut,
                  sizeCurve: Curves.easeInOut,
                );
              },
            )
          ],
        ),
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

  Widget _buildCountWithAddFriends() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
          height: 53,
          child: Row(
            children: [
              const Text(
                '🥳 친구 53',
                style: TextStyle(
                    fontFamily: kPaperlogyFont,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xff1947E5),
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.black, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '친구추가',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontFamily: kPaperlogyFont,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const Divider(
          height: 1.0,
        ),
      ],
    );
  }

  Widget _buildFriendList() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 188),
      child: ListView.separated(
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return _buildProfileSection();
        },
        separatorBuilder: (context, index) {
          return const Divider(height: 0.5);
        },
        itemCount: 10,
      ),
    );
  }

  Widget _buildProfileSection() {
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
                height: 24,
                decoration: ShapeDecoration(
                  color: const Color(0xffF2F2F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Center(
                    child: Text(
                      '😍 오늘도 맑음',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '강윤슬(눈물의달력)',
                style: TextStyle(
                    fontFamily: kPaperlogyFont, fontWeight: FontWeight.w500),
              ),
              const Text(
                '광주 북구 오룡동',
                style: TextStyle(
                    fontFamily: kPaperlogyFont,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff949494)),
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
          )
        ],
      ),
    );
  }
}
