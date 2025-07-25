import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practice01/src/ui/pages/example/bloc/expanded_bloc.dart';
import 'package:practice01/src/ui/widgets/hiteen_bottom_banner.dart';
import 'package:practice01/src/ui/widgets/hiteen_bottom_nav_bar.dart';

/// Custom Bottom Sheet
class TeenNowPage2 extends StatelessWidget {
  const TeenNowPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmojiBloc(),
      child: const TeenNowPageView2(),
    );
  }
}

class TeenNowPageView2 extends StatefulWidget {
  const TeenNowPageView2({super.key});

  @override
  State<TeenNowPageView2> createState() => _TeenNowPageView2State();
}

class _TeenNowPageView2State extends State<TeenNowPageView2> {
  final ValueNotifier<double> _sheetHeight = ValueNotifier(300.0);
  final double _minSheetHeight = 80.0;
  final double _maxSheetHeight = 500.0;
  final double _hiddenHeight = 0.0;

  double _dragStartY = 0.0;
  double _startHeight = 0.0;

  void _hidePanel() {
    _sheetHeight.value = _hiddenHeight;
  }

  void _collapsePanel() {
    _sheetHeight.value = _minSheetHeight;
  }

  void _expandPanel() {
    _sheetHeight.value = _maxSheetHeight;
  }

  @override
  void dispose() {
    _sheetHeight.dispose();
    super.dispose();
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

  // 드래그 가능한 바텀 시트 구현
  Widget _buildBottomDragSheet() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ValueListenableBuilder<double>(
        valueListenable: _sheetHeight,
        builder: (context, value, child) {
          return GestureDetector(
            // Drag down/up 처리
            onVerticalDragStart: (details) {
              _dragStartY = details.globalPosition.dy;
              _startHeight = value;
            },
            onVerticalDragUpdate: (details) {
              final drag = _dragStartY - details.globalPosition.dy;
              double newHeight =
                  (_startHeight + drag).clamp(_minSheetHeight, _maxSheetHeight);
              _sheetHeight.value = newHeight;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: value,
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
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
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      _sheetHeight.value = value == _minSheetHeight
                          ? _maxSheetHeight
                          : _minSheetHeight;
                    },
                    child: Container(
                      height: 50.0,
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.menu, size: 30),
                          SizedBox(width: 8),
                          Text('click or drag'),
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 0.5, color: Colors.grey),
                  // ListView 내용
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      physics: const ClampingScrollPhysics(),
                      itemCount: 20,
                      itemBuilder: (context, index) => ListTile(
                        title: Text('list item $index'),
                      ),
                      separatorBuilder: (context, index) =>
                          const Divider(height: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFloatingButtons() {
    return ValueListenableBuilder<double>(
      valueListenable: _sheetHeight,
      builder: (context, value, child) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          bottom: 16 + value,
          right: 16,
          child: Container(
            color: const Color.fromARGB(255, 21, 255, 0),
            child: Column(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.map_outlined)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.gps_fixed)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBackground() {
    return Container(
      color: Colors.grey.shade300,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('여기에 지도 및 캐릭터 UI 구성 예정'),
            IconButton(onPressed: () {}, icon: const Icon(Icons.abc)),
            IconButton(onPressed: _hidePanel, icon: const Icon(Icons.close)),
            IconButton(onPressed: _expandPanel, icon: const Icon(Icons.expand)),
            IconButton(
                onPressed: _collapsePanel,
                icon: const Icon(Icons.access_alarm)),
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
}
