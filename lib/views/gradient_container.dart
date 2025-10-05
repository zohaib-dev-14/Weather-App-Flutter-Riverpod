import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_yt/providers/gradient_provider.dart';


class GradientContainer extends ConsumerWidget {
  const GradientContainer({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(gradientProvider);
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: screenSize.height,
        width: screenSize.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors
            ),

        ),
      child: Padding(padding: const EdgeInsets.only(left: 24, right: 24, top: 36), child: CustomScrollView(

        slivers: [
          SliverList(delegate: SliverChildListDelegate(children))
        ],
      ),),
      ),
    );
  }
}