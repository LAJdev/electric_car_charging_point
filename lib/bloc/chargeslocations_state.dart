import 'package:flutter/material.dart';

import '../model/class.dart';

abstract class ChargeLocationsState {
  ChargeLocationsState();

}

class ChargeLocationsInitial extends ChargeLocationsState {}

class ChargeLocationsLoading extends ChargeLocationsState {}

class ChargeLocationsLoaded extends ChargeLocationsState {
  ChargeLocations? chargeLocations;
  ChargeLocationsLoaded(this.chargeLocations);
}

class ChargeLocationsError extends ChargeLocationsState {
  final String error;
  final IconData icon;
  ChargeLocationsError({required this.error, required this.icon});
}

class ChargeLocationsInternetConnexionError extends ChargeLocationsState {
  final String error;
  final IconData icon;
  ChargeLocationsInternetConnexionError(
      {required this.error, required this.icon});
}
