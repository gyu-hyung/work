import 'package:flutter/material.dart';

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool primary;

  const _IconText({
    required this.icon,
    required this.label,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color color =
        primary ? const Color(0xFF784FFF) : const Color(0xFF212121);

    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: color),
        ),
      ],
    );
  }
}

class DetailPage1 extends StatefulWidget {
  const DetailPage1({super.key});

  @override
  State<DetailPage1> createState() => _DetailPage1State();
}

class _DetailPage1State extends State<DetailPage1> {
  bool _emojiExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                _buildBackground(),
                _buildBackButton(context),
                _buildTopProfileIcon(context),
                _buildDraggableSheet(),
              ],
            ),
          ),
          _buildBottomBanner(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      color: Colors.grey.shade300,
      width: double.infinity,
      height: double.infinity,
      child: const Center(
        child: Text('여기에 지도 및 캐릭터 UI 구성 예정'),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: 54,
      left: 16,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFD4D4D4),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildTopProfileIcon(BuildContext context) {
    return Positioned(
      top: 54,
      right: 16,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            color: Color(0xFF9969FF),
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.antiAlias,
          child: Transform.scale(
            scale: 1.3,
            child: Image.asset(
              'assets/icons/ic_marker.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDraggableSheet() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.all(10),
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDragHandle(),
            _buildProfileSection(),
            _buildCounts(),
            // _buildButtons(),
            _buildEmojiSection(),
          ],
        ),
      ),
    );
  }

  /// 상단 드래그 핸들 위젯
  Widget _buildDragHandle() {
    return GestureDetector(
      onTap: () => setState(() => _emojiExpanded = !_emojiExpanded),
      child: Center(
        child: Container(
          width: 40,
          height: 5,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFDDDDDD),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // 프로필 정보 위젯
  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
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
                'assets/icons/ic_darcy_avartar.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Darcy',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_drop_down, size: 25),
                  ],
                ),
                // SizedBox(height: 4),
                Text('하이틴 고등학교 3학년 7반',
                    style: TextStyle(fontSize: 10, color: Color(0xFF212121))),
              ],
            ),
          ),
          // 오른쪽 버튼들
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline,
                color: Colors.black, size: 24),
            onPressed: () {/* 채팅 기능 */},
          ),
          IconButton(
            icon:
                const Icon(Icons.favorite_border, color: Colors.red, size: 24),
            onPressed: () {/* 좋아요 기능 */},
          ),
        ],
      ),
    );
  }

  // 숫자 위젯
  Widget _buildCounts() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 16,
        children: [
          _IconText(
              icon: Icons.thumb_up_alt_outlined,
              label: '85421796',
              primary: true),
          _IconText(icon: Icons.mode_comment_outlined, label: '58932'),
          _IconText(icon: Icons.remove_red_eye_outlined, label: '747865'),
        ],
      ),
    );
  }

//버튼
  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: SizedBox(
              height: 46,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF784FFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: 0,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: const Text(
                  '버튼',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 46,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF6F6F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: 0,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: const Text(
                  '버튼',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 이모지 선택 위젯
  Widget _buildEmojiSection() {
    final emojis = [
      '😍', '😂', '🥳', '🤩', '🤯', '😱', '🔥', '💯',
      '😍', '😂', '🥳', '🤩', '🤯', '😱', '🔥', '💯',
      '😍', '😂', '🥳', '🤩', '🤯', '😱', '🔥', '💯',
      // '😍', '😂', '🥳', '🤩', '🤯', '😱', '🔥', '💯',
      // '😍', '😂', '🥳', '🤩', '🤯', '😱', '🔥', '💯',
      // '😍', '😂', '🥳', '🤩', '🤯', '😱', '🔥', '💯',
    ];

    return AnimatedCrossFade(
      crossFadeState:
          _emojiExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 300),
      sizeCurve: Curves.easeInOutCirc,
      firstChild: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: _buildButtons(),
      ),
      secondChild: Container(
        //그리드뷰 최대크기 지정
        height: 190,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(24),
        ),
        child: GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(32.5, 21, 32.5, 17),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: emojis.length,
          itemBuilder: (context, index) {
            return Center(
              child: Text(emojis[index], style: const TextStyle(fontSize: 44)),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomBanner() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 83,
      child: Container(
        height: 59,
        width: 350,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              width: 350,
              child: Image.asset(
                'assets/banners/banner1.png',
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}
