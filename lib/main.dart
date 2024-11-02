import 'package:flutter/material.dart';

import 'bloc/chargeslocations_bloc.dart';
import 'screens/chargelocationdetails_page.dart';
import 'screens/chargelocations_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final ChargeLocationsBloc chargeLocationsBloc = ChargeLocationsBloc();
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const ChargeLocationsPage(),
        "/ChargeLocationDetailsPage": (context) =>
            const ChargeLocationDetailsPage()
      },
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          // ···
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
