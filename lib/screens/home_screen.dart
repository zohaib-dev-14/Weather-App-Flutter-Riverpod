import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_yt/constants/navigation_screen.dart';
import 'package:weather_app_yt/providers/navigation_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationIndex = ref.watch(navigationProvider);

    return Scaffold(
      body: IndexedStack(index: navigationIndex, children: screens),

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1A2B4C), // Dark navy blue
        ),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: navigationIndex,
          elevation: 10,
          backgroundColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          destinations: destinations,
          surfaceTintColor: Colors.transparent,
          onDestinationSelected: (value) {
            ref.read(navigationProvider.notifier).state = value;
          },
        ),
      ),
    );
  }
}




              // onDestinationSelected: (value) {
              //   ref.read(navigationProvider.notifier).state = value;
              // },