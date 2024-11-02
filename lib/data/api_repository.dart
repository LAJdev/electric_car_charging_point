import 'location_provider.dart';
import '../model/class.dart';

class ApiRepository {
  final provider = ApiProvider();

  Future<ChargeLocations> getChargeLocations(String city) async {
    ChargeLocations chargelocations = await provider.getChargeLocations(city);
    return chargelocations;
  }
}
