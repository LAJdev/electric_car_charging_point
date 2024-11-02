import 'package:flutter/material.dart';

import '../bloc/chargeslocations_state.dart';

class ChargeLocationListWidget extends StatelessWidget {
  const ChargeLocationListWidget({super.key, required this.state});

  final ChargeLocationsLoaded state;

  @override
  Widget build(BuildContext context) {
    int chargelocationslength = state.chargeLocations!.chargelocations!.length;
    var chargelocationsstate = state.chargeLocations!.chargelocations!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: chargelocationslength,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          "/ChargeLocationDetailsPage",
                          arguments: chargelocationsstate[index].evses);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 242, 253, 242),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Theme.of(context).primaryColor)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                  "Address: ${chargelocationsstate[index].address}"),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                  "City: ${chargelocationsstate[index].city}"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                backgroundColor: chargelocationsstate[index]
                                            .evses
                                            .isavailable ==
                                        null
                                    ? Colors.transparent
                                    : chargelocationsstate[index]
                                            .evses
                                            .isavailable!
                                        ? Colors.green
                                        : Colors.red,
                                radius: 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                      "Available EVSES: ${chargelocationsstate[index].evses.evses.where((element) => element.status == "AVAILABLE").length}"),
                                  Text(
                                      "Total EVSES: ${chargelocationsstate[index].evses.evses.length}"),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }
}
