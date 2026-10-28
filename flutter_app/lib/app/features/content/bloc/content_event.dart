part of 'content_bloc.dart';

sealed class ContentEvent extends Equatable {
  const ContentEvent();

  @override
  List<Object?> get props => [];
}

final class ContentLoad extends ContentEvent {
  const ContentLoad({required this.contentId});

  final int contentId;

  @override
  List<Object?> get props => [contentId];
}
