import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final borderGradientProvider = Provider<List<Color>>((ref) {
  final hour = DateTime.now().hour;

  if (hour >= 6 && hour < 12) {
    // Morning 🌅 (fresh + vibrant)
    return [
      Colors.pinkAccent.shade200,
      Colors.orangeAccent.shade400,
      Colors.yellowAccent.shade700,
    ];
  } else if (hour >= 12 && hour < 18) {
    // Afternoon ☀️ (bright + sharp)
    return [
      Colors.cyanAccent.shade400,
      Colors.lightGreenAccent.shade400,
      Colors.amberAccent.shade700,
    ];
  } else {
    // Night 🌙 (glow effect)
    return [
      Colors.deepPurpleAccent.shade200,
      Colors.indigoAccent.shade400,
      Colors.blueAccent.shade700,
    ];
  }
});
