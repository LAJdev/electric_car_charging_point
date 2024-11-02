abstract class ChargesLocationsEvent {
  ChargesLocationsEvent();
}

class GetChargeLocationsEvent extends ChargesLocationsEvent {
  final String city;
  final int maximumlocations;
  GetChargeLocationsEvent({required this.maximumlocations, required this.city});
}

