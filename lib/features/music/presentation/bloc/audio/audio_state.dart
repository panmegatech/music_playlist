part of 'audio_cubit.dart';

class AudioState extends Equatable {
  final bool isPlaying;
  final Duration position;
  final Duration? duration;

  const AudioState({
    required this.isPlaying,
    required this.position,
    this.duration,
  });

  AudioState copyWith({
    bool? isPlaying,
    Duration? position,
    Duration? duration,
  }) {
    return AudioState(
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
    );
  }

  static AudioState initial() => const AudioState(
      isPlaying: false, position: Duration.zero, duration: Duration.zero);

  @override
  List<Object?> get props => [
        isPlaying,
        position,
        duration,
      ];
}
