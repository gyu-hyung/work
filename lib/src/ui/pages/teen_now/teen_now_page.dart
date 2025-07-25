import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:practice01/src/ui/pages/teen_now/teen_now_bottom_sheet_page.dart';
import 'package:practice01/src/ui/widgets/hiteen_bottom_banner.dart';
import 'package:practice01/src/ui/widgets/hiteen_bottom_nav_bar.dart';

class TeenNowPage extends StatelessWidget {
  const TeenNowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TeenNowPageView();
  }
}

class TeenNowPageView extends StatefulWidget {
  const TeenNowPageView({super.key});

  @override
  State<TeenNowPageView> createState() => _TeenNowPageViewState();
}

class _TeenNowPageViewState extends State<TeenNowPageView> {
  final SlidingUpPanelController panelController = SlidingUpPanelController();
  final ScrollController scrollController = ScrollController();
  final ValueNotifier<double> _sheetHeight = ValueNotifier(0.0);

  final double anchor = 0.28;
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
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          minBound = 0.28;
          upperBound = 0.6;
        }));
  }

  void _scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                _buildMapView(),
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

  Widget _buildMapView() {
    const seoulCityHall = NLatLng(37.5666, 126.979);

    final safeAreaPadding = MediaQuery.paddingOf(context);
    return NaverMap(
      options: NaverMapViewOptions(
        contentPadding: safeAreaPadding,
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
      },
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
          bottom: ((MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height / 5)) * value) + 16,
          right: 16,
          child: Column(
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
                  icon: SvgPicture.asset('assets/icons/ic_float_2.svg')),
              IconButton(
                  onPressed: _scrollToTop,
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
