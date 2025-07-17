import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User extends Equatable {
  const User({
    required this.id,
    this.name = '게스트',
    this.phone = '',
    this.type = UserType.customer,
    // this.store,
    // this.company,
    // this.position,
    this.image,
  });

  /// 사용자 ID
  @JsonKey(name: 'userid')
  final String id;

  /// 사용자 이름
  final String name;

  /// 사용자 전화번호
  final String phone;

  /// 사용자 타입
  final UserType type;

  /// 상점 정보 (상점 주인용)
  // final Store? store;

  // /// 회사(지역) 정보
  // final Company? company;

  // /// 배달장소
  // final Position? position;

  /// 사용자 프로필 이미지
  final String? image;

  bool get isGuest => type == UserType.guest;

  // int get deliveryPrice =>
  //     position?.deliveryInfo?.deliveryPrice ?? company?.deliveryPrice ?? 0;

  static const empty = User(id: '', name: '', phone: '');
  static const sample = User(id: '1', name: 'John Doe', phone: '010-1234-1234');
  static const guest = User(
      id: 'guest', name: 'Guest', phone: '010-0000-0000', type: UserType.guest);
  static const storeOwner = User(
    id: 'storeOwner',
    name: 'Store Owner',
    phone: '010-0000-0000',
    type: UserType.storeOwner,
    // store: Store.sample,
  );

  // factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? name,
    String? phone,
    UserType? type,
    // Option<Store>? store,
    // Option<Company>? company,
    // Option<Position>? position,
    String? image,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      type: type ?? this.type,
      // store: store != null ? store.toNullable() : this.store,
      // company: company != null ? company.toNullable() : this.company,
      // position: position != null ? position.toNullable() : this.position,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        type,
        // store,
        // company,
        // position,
        image,
      ];
}

enum UserType {
  @JsonValue('User')
  customer,
  @JsonValue('Guest')
  guest,
  @JsonValue('Store')
  storeOwner
}
