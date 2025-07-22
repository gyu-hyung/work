import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
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
      dragEnd: (details) {
        final velocity = details.velocity.pixelsPerSecond.dy;

        if (velocity <= 100.0) {
          if (panelController.status == SlidingUpPanelStatus.collapsed) {
            panelController.hide();
          }
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
            Container(
              alignment: Alignment.center,
              height: 30.0,
              child: Container(
                width: 40, // 핸들 길이 (적당히 조절)
                height: 5, // 핸들 두께
                // margin: const EdgeInsets.symmetric(vertical: 12), // 위아래 여백
                decoration: BoxDecoration(
                  color: Colors.grey.shade300, // 핸들 색상 (더 연하게 하려면 shade200 등)
                  borderRadius: BorderRadius.circular(3), // 둥글기(두께 절반)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
