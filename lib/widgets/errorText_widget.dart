import 'package:flutter/material.dart';

class ErrorTextStateWidget extends StatelessWidget {
  const ErrorTextStateWidget(
      {super.key, required this.errortext, required this.icon});

  final String errortext;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 64,
        ),
        Text(
          errortext,
          style: theme.textTheme.headlineSmall,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}