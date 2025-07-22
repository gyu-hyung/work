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
  final ValueNotifier<double> _sheetHeight = ValueNotifier(180.0);

  late final SlidingUpPanelController panelController;

  double anchor = 0.5;
  double minBound = 0.5;
  double upperBound = 1.0;

  @override
  void dispose() {
    panelController.dispose();
    _sheetHeight.dispose();
    super.dispose();
  }

  @override
  void initState() {
    panelController = SlidingUpPanelController();
    super.initState();
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
                    onPressed: panelController.expand,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                    ),
                    icon: SvgPicture.asset('assets/icons/ic_float_1.svg')),
                IconButton(
                    onPressed: panelController.collapse,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                    ),
                    icon: SvgPicture.asset('assets/icons/ic_float_2.svg')),
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
      controlHeight: 10.1,
      anchor: anchor,
      minimumBound: minBound,
      upperBound: upperBound,
      panelController: panelController,
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
              {_sheetHeight.value = 370.0}
            else if (panelController.status == SlidingUpPanelStatus.anchored)
              {_sheetHeight.value = 180.0}
            else if (panelController.status == SlidingUpPanelStatus.collapsed)
              {_sheetHeight.value = 180.0}
            else
              {_sheetHeight.value = 0.0}
          }
      },
      child: Container(
        decoration: const ShapeDecoration(
          color: Colors.white,
          shadows: [
            BoxShadow(
                blurRadius: 5.0, spreadRadius: 2.0, color: Color(0x11000000))
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDragHandle(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Color(0xFF9969FF),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(18)),
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
                  const SizedBox(width: 12),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // width: 100,
                        height: 20,
                        decoration: ShapeDecoration(
                          color: const Color(0xffF2F2F2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999.0),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '😍 오늘도 맑음',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      const Text(
                        '강윤슬(눈물의달력)',
                        style: TextStyle(
                            fontFamily: kPaperlogyFont,
                            fontWeight: FontWeight.w500),
                      ),
                      const Text(
                        '광주 북구 오룡동',
                        style: TextStyle(
                            fontFamily: kPaperlogyFont,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const Spacer(),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.amber, // 노란 배경
                      foregroundColor: Colors.black, // 글자색
                      side: const BorderSide(
                          color: Colors.black, width: 2), // 검은 테두리
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // 모서리 둥글기
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('프로필'),
                  )
                ],
              ),
            ),
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
}
