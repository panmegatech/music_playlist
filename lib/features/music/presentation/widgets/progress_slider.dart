import 'package:flutter/material.dart';

class ProgressSlider extends StatelessWidget {
  final Duration position;
  final Duration duration;
  final ValueChanged<Duration> onChanged;

  const ProgressSlider({
    super.key,
    required this.position,
    required this.duration,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Slider(
      inactiveColor: colorScheme.onPrimary.withValues(alpha: .1),
      min: 0.0,
      max: duration.inMilliseconds.toDouble(),
      value:
          position.inMilliseconds.clamp(0, duration.inMilliseconds).toDouble(),
      onChanged: (newValue) {
        onChanged(Duration(milliseconds: newValue.toInt()));
      },
    );
  }
}
