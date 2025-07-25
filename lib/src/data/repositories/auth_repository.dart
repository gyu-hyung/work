import 'package:practice01/src/data/models/teen_friend.dart';

abstract interface class AuthRepository {
  Future<TeenNowFriend> fetchFriends();
  Future<List<TeenNowFriend>> fetchFriendsSample();
}
