import 'package:flutter/material.dart';

import '../model/class.dart';

class ChargeLocationDetailsPage extends StatelessWidget {
  const ChargeLocationDetailsPage({super.key});

  static const routeName = '/ChargeLocationDetailsPage';

  @override
  Widget build(BuildContext context) {
    final Evses? args = ModalRoute.of(context)?.settings.arguments as Evses?;
    if (args == null) {
      return const Scaffold(
        body: Text("Null value"),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[200],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: args.evses.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 242, 253, 242),
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                      ),
                      child: Column(
                        children: [
                          // Text(args.evses[index].evseId),
                          Text(args.evses[index].status),
                          Text(args.evses[index].connectorType),
                          Text(args.evses[index].powerType),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
