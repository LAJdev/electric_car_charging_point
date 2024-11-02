import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/api_repository.dart';
import '../model/class.dart';
import 'chargeslocations_event.dart';
import 'chargeslocations_state.dart';

class ChargeLocationsBloc
    extends Bloc<ChargesLocationsEvent, ChargeLocationsState> {
  ChargeLocationsBloc() : super(ChargeLocationsInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    List<ChargeLocation> isavailablefunction(ChargeLocations chargelocations) {
      bool isavailable;
      List<ChargeLocation> listchargelocation = [];
      for (var elementlocation in chargelocations.chargelocations!) {
        late ChargeLocation chargelocationupdated;
        late Evses evsesupdated;
        var totalevse = elementlocation.evses.evses.length;
        var availableevse = elementlocation.evses.evses
            .where((element) => element.status == "AVAILABLE")
            .length;
        if ((availableevse / totalevse) > 0.5) {
          isavailable = true;
        } else {
          isavailable = false;
        }
        // Evses updated. Checking if the the charge location is available or unavailable.
        evsesupdated =
            Evses(evses: elementlocation.evses.evses, isavailable: isavailable);
            
        // New charge location with evses updated
        chargelocationupdated = ChargeLocation(
            address: elementlocation.address,
            city: elementlocation.city,
            country: elementlocation.country,
            latitude: elementlocation.latitude,
            longitude: elementlocation.longitude,
            evses: evsesupdated);
        listchargelocation.add(chargelocationupdated);
      }
      return listchargelocation;
    }

    on<GetChargeLocationsEvent>((event, emit) async {
      try {
        emit(ChargeLocationsLoading());
        final chargelocations =
            await apiRepository.getChargeLocations(event.city);
        if (chargelocations.statuscode == 200) {
         
          ChargeLocations? chargeLocationsupdated;
          if (chargelocations.chargelocations != null) {
            
            // updating the data, checking if the charging station is available or unavailable 
            // when the user search charging points in a city.
            List<ChargeLocation> x = isavailablefunction(chargelocations);

            chargeLocationsupdated = ChargeLocations(
              chargelocations: x,
              statuscode: chargelocations.statuscode,
            );

            emit(ChargeLocationsLoaded(chargeLocationsupdated));
          } else {
            emit(ChargeLocationsError(
                error: "---- Error_1 ----", icon: Icons.error_outline_outlined));
          }

        } else if (chargelocations.statuscode == 400) {
          emit(ChargeLocationsError(
              error: "---- Http Bad Request ----",
              icon: Icons.sentiment_dissatisfied_outlined));
        } else if (chargelocations.statuscode == 401) {
          emit(ChargeLocationsError(
              error: "---- Unauthorized ----", icon: Icons.dangerous_outlined));
        } else if (chargelocations.statuscode == 404) {
          emit(ChargeLocationsInternetConnexionError(
              error: "---- Network is not available ----",
              icon: Icons.wifi_off_outlined));
        } else {
          emit(ChargeLocationsError(
              error: "---- Error_2 ----", icon: Icons.error_outline_outlined));
        }
      } catch (e) {
        emit(ChargeLocationsError(
            error: "---- Error_3 ----", icon: Icons.error_outline_outlined));
      }
    });
  }
}
