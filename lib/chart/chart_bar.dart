import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({required this.fill, super.key});

  final double fill;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: FractionallySizedBox(
        heightFactor: fill,
        child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : Theme.of(context).colorScheme.primary.withOpacity(
                        0.6,
                      )),
        ),
      ),
    ));
  }
}
