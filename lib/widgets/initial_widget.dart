import 'package:flutter/material.dart';

class InitialStateWidget extends StatelessWidget {
  const InitialStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.power,
          size: 64,
        ),
        Text(
          'Please enter a city in the searchfield above',
          style: theme.textTheme.headlineSmall,
          maxLines: 3,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}