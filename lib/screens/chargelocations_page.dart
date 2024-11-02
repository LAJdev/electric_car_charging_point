import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/chargeslocations_bloc.dart';
import '../bloc/chargeslocations_state.dart';
import '../widgets/chargelocationlist_widget.dart';
import '../widgets/errorText_widget.dart';
import '../widgets/initial_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/search_widget.dart';

class ChargeLocationsPage extends StatefulWidget {
  const ChargeLocationsPage({
    super.key,
  });

  @override
  State<ChargeLocationsPage> createState() => _ChargeLocationsPageState();
}

class _ChargeLocationsPageState extends State<ChargeLocationsPage> {
  final ChargeLocationsBloc chargeLocationsBloc = ChargeLocationsBloc();
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => chargeLocationsBloc,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: SearchStateWidget(textController: _textController),
              ),
              Expanded(
                child: Center(
                  child: BlocBuilder<ChargeLocationsBloc, ChargeLocationsState>(
                    builder: (builder, state) {
                      if (state is ChargeLocationsInitial) {
                        return const InitialStateWidget();
                      } else if (state is ChargeLocationsLoading) {
                        return const LoadingStateWidget();
                      } else if (state is ChargeLocationsLoaded) {
                        return ChargeLocationListWidget(state: state);
                      } else if (state
                          is ChargeLocationsInternetConnexionError) {
                        return ErrorTextStateWidget(
                          errortext: state.error,
                          icon: state.icon,
                        );
                      } else if (state is ChargeLocationsError) {
                        return ErrorTextStateWidget(
                          errortext: state.error,
                          icon: state.icon,
                        );
                      } else {
                        return const ErrorTextStateWidget(
                          errortext: "Error",
                          icon: Icons.sentiment_dissatisfied_outlined,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
