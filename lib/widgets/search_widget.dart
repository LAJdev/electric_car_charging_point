import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chargeslocations_bloc.dart';
import '../bloc/chargeslocations_event.dart';
import '../constants/constants.dart';

class SearchStateWidget extends StatelessWidget {
  const SearchStateWidget({
    super.key,
    required TextEditingController textController,
  }) : _textController = textController;

  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'City',
                hintText: 'Amsterdam',
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.search, semanticLabel: 'Submit'),
          onPressed: () {
            context.read<ChargeLocationsBloc>().add(GetChargeLocationsEvent(
                city: _textController.text,
                maximumlocations: maximumlocations));
          },
        ),
      ],
    );
  }
}