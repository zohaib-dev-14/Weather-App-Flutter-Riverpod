import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gradientProvider = Provider<List<Color>>((ref) {
  final hour = DateTime.now().hour;

  if (hour >= 6 && hour < 12) {
    // Morning 🌅
    return [
      Colors.orange.shade700,
      Colors.amber.shade800,
      Colors.blue.shade800,
    ];
  } else if (hour >= 12 && hour < 18) {
    // Afternoon ☀️
    return [
      Colors.lightBlue.shade200,
      Colors.blue.shade200,
      Colors.indigo.shade200,
    ];
  } else {
    // Night 🌙
    return [
      Colors.deepPurple.shade700, // thoda halka purple (900 se soft)
      Colors.indigo.shade600, // medium indigo touch
      Colors.blueGrey.shade400,
    ];
  }
});




// open weather map api
// open meteo weather api
