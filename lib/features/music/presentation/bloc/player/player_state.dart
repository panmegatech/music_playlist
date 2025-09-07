part of 'player_cubit.dart';

class PlayerState extends Equatable {
  final bool isLoading;
  final bool isPlaying;

  const PlayerState({required this.isLoading, required this.isPlaying});

  @override
  List<Object?> get props => [
        isLoading,
        isPlaying,
      ];

  PlayerState copyWith({bool? isLoading, bool? isPlaying}) => PlayerState(
        isLoading: isLoading ?? this.isLoading,
        isPlaying: isPlaying ?? this.isPlaying,
      );
}
