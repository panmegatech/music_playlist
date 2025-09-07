part of 'player_cubit.dart';

sealed class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object?> get props => [];
}

final class PlayerInitialState extends PlayerState {}

final class PlayerLoadingState extends PlayerState {}

final class PlayerErrorState extends PlayerState {}

final class PlayerHasDataState extends PlayerState {}
