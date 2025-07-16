import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc 클래스 정의
class EmojiBloc extends Bloc<ExpandedEvent, EmojiState> {
  EmojiBloc() : super(const EmojiInitial()) {
    on<ToggleEmoji>(_onToggleEmoji);
  }

  void _onToggleEmoji(ToggleEmoji event, Emitter<EmojiState> emit) {
    emit(EmojiToggled(!state.isExpanded));
  }
}

// 상태 정의
abstract class EmojiState extends Equatable {
  final bool isExpanded;
  const EmojiState(this.isExpanded);
}

class EmojiInitial extends EmojiState {
  const EmojiInitial() : super(false);

  @override
  List<Object?> get props => [isExpanded];
}

class EmojiToggled extends EmojiState {
  const EmojiToggled(super.isExpanded);

  @override
  List<Object?> get props => [isExpanded];
}

// 이벤트 정의
abstract class ExpandedEvent {}

class ToggleEmoji extends ExpandedEvent {}
