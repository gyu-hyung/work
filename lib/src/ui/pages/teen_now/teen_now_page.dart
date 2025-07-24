import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:practice01/src/ui/pages/teen_now/bloc/expanded_bloc.dart';
import 'package:practice01/src/ui/pages/teen_now/teen_now_bottom_sheet_page.dart';
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

  double anchor = 0.28;
  double minBound = 0;
  double upperBound = 1.0;
  //panel
  bool showFriendDetail = false;

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
          minBound = 0.28;
          anchor = 0.28;
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
    const seoulCityHall = NLatLng(37.5666, 126.979);
    final safeAreaPadding = MediaQuery.paddingOf(context);
    return NaverMap(
      options: NaverMapViewOptions(
        contentPadding:
            safeAreaPadding, // 화면의 SafeArea에 중요 지도 요소가 들어가지 않도록 설정하는 Padding. 필요한 경우에만 사용하세요.
        initialCameraPosition:
            const NCameraPosition(target: seoulCityHall, zoom: 14),
      ),
      onMapReady: (controller) {
        final marker = NMarker(
          id: "city_hall", // Required
          position: seoulCityHall, // Required
          caption: const NOverlayCaption(text: "서울시청"), // Optional
        );
        controller.addOverlay(marker); // 지도에 마커를 추가
        print("naver map is ready!");
      },
    );
    // return Container(
    //   color: Colors.grey.shade300,
    //   width: double.infinity,
    //   height: double.infinity,
    //   child: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             IconButton(
    //                 onPressed: panelController.collapse,
    //                 style: IconButton.styleFrom(
    //                   backgroundColor: Colors.white,
    //                   shape: const CircleBorder(),
    //                 ),
    //                 icon: SvgPicture.asset('assets/icons/ic_float_1.svg')),
    //             IconButton(
    //                 onPressed: panelController.hide,
    //                 style: IconButton.styleFrom(
    //                   backgroundColor: Colors.white,
    //                   shape: const CircleBorder(),
    //                 ),
    //                 icon: SvgPicture.asset('assets/icons/ic_float_3.svg')),
    //           ],
    //         ),
    //         const Text('여기에 지도 및 캐릭터 UI 구성 예정'),
    //       ],
    //     ),
    //   ),
    // );
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
          bottom: ((value) *
                  (MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).size.height / 5))) +
              16,
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
      anchor: anchor,
      enableOnTap: false,
      controlHeight: 10.0,
      upperBound: upperBound,
      minimumBound: minBound,
      panelController: panelController,
      panelStatus: SlidingUpPanelStatus.hidden,
      child: TeenNowBottomSheetPage(
          minBound: minBound,
          sheetHeight: _sheetHeight,
          scrollController: scrollController),
      dragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dy <= 100.0) {
          if (panelController.status == SlidingUpPanelStatus.collapsed) {
            panelController.hide();
          }
        }
      },
      onStatusChanged: (details) => {
        if (panelController.status != SlidingUpPanelStatus.dragging)
          {
            if (panelController.status == SlidingUpPanelStatus.expanded)
              {_sheetHeight.value = upperBound}
            else if (panelController.status == SlidingUpPanelStatus.anchored ||
                panelController.status == SlidingUpPanelStatus.collapsed)
              {_sheetHeight.value = minBound}
            else
              {_sheetHeight.value = 0.0}
          },
      },
    );
  }
}
