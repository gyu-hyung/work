class Feed {
  // 유저 ID
  final String userId;
  // 피드 작성자
  final String userName;
  // 피드 작성자 썸네일
  final String userAvatar;
  // 피드 이미지
  final List<String> images;
  // 피드 텍스트
  final String text;
  // 작성 시간
  final String timeAgo;
  // 좋아요 수
  final int likes;
  // 댓글 수
  final int comments;
  // 조회수
  final int views;

  Feed({
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.images,
    required this.text,
    required this.timeAgo,
    required this.likes,
    required this.comments,
    required this.views,
  });
}
