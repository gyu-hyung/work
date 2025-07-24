import 'package:flutter/material.dart';

class ReactionAvatarStack extends StatelessWidget {
  final List<String> reactionAvatars;
  final double avatarSize;
  final double distance;

  const ReactionAvatarStack({
    super.key,
    required this.reactionAvatars,
    this.avatarSize = 20,
    this.distance = 20,
  });

  @override
  Widget build(BuildContext context) {
    final int lastAvatarIndex = reactionAvatars.length;

    return SizedBox(
      height: avatarSize * 2,
      child: Stack(
        children: [
          for (int i = 0; i < lastAvatarIndex; i++)
            Positioned(
              left: i * distance,
              child: CircleAvatar(
                radius: avatarSize,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: avatarSize - 2,
                  backgroundImage: AssetImage(reactionAvatars[i]),
                ),
              ),
            ),
          Positioned(
            left: lastAvatarIndex * distance,
            child: CircleAvatar(
              radius: avatarSize,
              backgroundColor: Colors.black,
              child: const Icon(Icons.chevron_right, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
