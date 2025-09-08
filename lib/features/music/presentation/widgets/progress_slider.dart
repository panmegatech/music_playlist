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
    final max = duration.inMilliseconds.toDouble();
    final value = position.inMilliseconds.clamp(0, max);

    return Slider(
      min: 0.0,
      max: max > 0 ? max : 1.0,
      value: value.toDouble(),
      onChanged: (newValue) {
        onChanged(Duration(milliseconds: newValue.toInt()));
      },
    );
  }
}
