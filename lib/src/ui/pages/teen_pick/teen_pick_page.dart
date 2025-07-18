import 'package:flutter/material.dart';
import 'package:practice01/src/ui/pages/teen_pick/widgets/swiper_card.dart';
import 'package:practice01/src/ui/widgets/hiteen_bottom_banner.dart';
import 'package:practice01/src/ui/widgets/hiteen_logo_app_bar.dart';

class TeenPickPage extends StatelessWidget {
  const TeenPickPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TeenPickPageView();
  }
}

class TeenPickPageView extends StatelessWidget {
  const TeenPickPageView({super.key});

  Widget _buildHiteenLogoAppBar() {
    return const HiteenLogoAppBar();
  }

  Widget _buildBottomBanner() {
    return const HiteenBottomBanner();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0XffF6F6F6),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: screenHeight * 0.75,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    _buildHiteenLogoAppBar(),
                    const SwiperCard(),
                    // _buildSwipeCard(),
                    _buildStatsRow(
                        likes: 85421796, comments: 58932, views: 747865),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 23),
          _buildWordMemorySection(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: screenHeight * 0.11,
        ),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF784FFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          child: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
      ),
      bottomNavigationBar: _buildBottomBanner(),
    );
  }

  Widget _buildStatsRow({
    required int likes,
    required int comments,
    required int views,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 16),
      child: Row(
        children: [
          const SizedBox(width: 4),
          const Icon(
            Icons.thumb_up_alt_outlined,
            size: 20,
            color: Color(0xFF784FFF),
          ),
          const SizedBox(width: 4),
          Text(
            likes.toString(),
            style: const TextStyle(color: Color(0xFF784FFF)),
          ),
          const SizedBox(width: 16),
          const Icon(Icons.chat_bubble_outline, size: 20),
          const SizedBox(width: 4),
          Text(comments.toString()),
          const SizedBox(width: 16),
          const Icon(Icons.remove_red_eye_outlined, size: 20),
          const SizedBox(width: 4),
          Text(views.toString()),
        ],
      ),
    );
  }

  Widget _buildWordMemorySection() {
    final List<String> reactionAvatars = [
      'assets/icons/ic_marker1.png',
      'assets/icons/ic_marker2.png',
      'assets/icons/ic_marker3.png',
      'assets/icons/ic_marker4.png',
      'assets/icons/ic_marker5.png',
      'assets/icons/ic_marker6.png',
    ];
    final int lastAvartarIndex = reactionAvatars.length;
    const double avartarSize = 20;
    const double distance = 20;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '단어암기',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Image.asset('assets/images/level2.png', width: 100),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 40,
                child: Stack(
                  children: [
                    for (int i = 0; i < lastAvartarIndex; i++)
                      Positioned(
                        left: i * distance,
                        child: CircleAvatar(
                          radius: avartarSize,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: avartarSize - 2,
                            backgroundImage: AssetImage(reactionAvatars[i]),
                          ),
                        ),
                      ),
                    Positioned(
                      left: lastAvartarIndex * distance,
                      child: const CircleAvatar(
                        radius: avartarSize,
                        backgroundColor: Colors.black,
                        child: Icon(Icons.chevron_right, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
