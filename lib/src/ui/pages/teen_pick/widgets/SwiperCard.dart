import 'dart:ui';
import 'package:flutter/material.dart';

class SwiperCard extends StatefulWidget {
  const SwiperCard({super.key});

  @override
  State<SwiperCard> createState() => _SwiperCardState();
}

class _SwiperCardState extends State<SwiperCard> {
  List<Color> cardColors = [
    const Color(0xFFFF3377), // 핑크
    const Color(0xFF784FFF), // 보라
    const Color(0xFF00D1FF), // 파랑
  ];

  int centerIndex = 1;
  double dx = 0;

  @override
  Widget build(BuildContext context) {
    int leftIndex = (centerIndex - 1 + cardColors.length) % cardColors.length;
    int rightIndex = (centerIndex + 1) % cardColors.length;

    const double cardWidth = 295;
    const double cardHeight = 427;
    const double sideCardScale = 0.88;
    const double sideCardOffset = 54; // 더 크게 잡아서 많이 튀어나오게

    return Center(
      child: SizedBox(
        width: cardWidth + sideCardOffset * 2,
        height: cardHeight + 40,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // 왼쪽 카드 (블러)
            Positioned(
              left: 0,
              top: 20,
              child: Transform.scale(
                scale: sideCardScale,
                child: CardWidget(
                  color: cardColors[leftIndex],
                  blur: true,
                  width: cardWidth,
                  height: cardHeight,
                ),
              ),
            ),
            // 오른쪽 카드 (블러)
            Positioned(
              right: 0,
              top: 20,
              child: Transform.scale(
                scale: sideCardScale,
                child: CardWidget(
                  color: cardColors[rightIndex],
                  blur: true,
                  width: cardWidth,
                  height: cardHeight,
                ),
              ),
            ),
            // 중앙 카드
            AnimatedPositioned(
              duration: const Duration(milliseconds: 0),
              left: sideCardOffset + dx,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    dx += details.delta.dx;
                  });
                },
                onHorizontalDragEnd: (details) {
                  if (dx.abs() > 100) {
                    if (dx < 0) {
                      setState(() {
                        centerIndex = (centerIndex + 1) % cardColors.length;
                        dx = 0;
                      });
                    } else {
                      setState(() {
                        centerIndex = (centerIndex - 1 + cardColors.length) %
                            cardColors.length;
                        dx = 0;
                      });
                    }
                  } else {
                    setState(() {
                      dx = 0;
                    });
                  }
                },
                child: CardWidget(
                  color: cardColors[centerIndex],
                  blur: false,
                  width: cardWidth,
                  height: cardHeight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final Color color;
  final bool blur;
  final double width;
  final double height;

  const CardWidget({
    super.key,
    required this.color,
    required this.blur,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: Offset(0, 6),
          )
        ],
      ),
    );

    if (!blur) return card;

    // 1. 카드 전체에 blur
    Widget blurred = ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
        child: card,
      ),
    );

    // 2. 좌우 ShaderMask
    Widget horizontalMask = ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.transparent, // 왼쪽 투명
            Colors.black, // 중앙 불투명
            Colors.black, // 중앙 불투명
            Colors.transparent // 오른쪽 투명
          ],
          stops: [0.0, 0.08, 0.92, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: blurred,
    );

    // 3. 위아래 ShaderMask
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent, // 위쪽 투명
            Colors.black, // 중앙 불투명
            Colors.black, // 중앙 불투명
            Colors.transparent // 아래쪽 투명
          ],
          stops: [0.0, 0.08, 0.92, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: horizontalMask,
    );
  }
}
