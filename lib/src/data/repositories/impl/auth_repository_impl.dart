import 'package:practice01/src/data/repositories/auth_repository.dart';
import 'package:practice01/src/data/models/teen_friend.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<TeenNowFriend> fetchFriends() {
    throw UnimplementedError();
  }

  @override
  Future<List<TeenNowFriend>> fetchFriendsSample() {
    print('AuthRepositoryImpl.fetchFriendsSample');
    return Future.value(TeenNowFriend.sampleList);
  }
}
