import '../model/class.dart';
import 'package:dio/dio.dart';

import '../constants/constants.dart';

class ApiProvider {
  final dio = Dio();

  Future<ChargeLocations> getChargeLocations(String city) async {
    try {
      final response = await dio.get(
        url,
        queryParameters: {
          "q": city,
        },
        options: Options(
          headers: {
            "Authorization": apiKey,
          },
        ),
      );
      if (response.statusCode != null) {
        ChargeLocations completelist = ChargeLocations.fromJson(
            response.data!, maximumlocations, response.statusCode!);
        return ChargeLocations.success(
            response.statusCode!, completelist.chargelocations!,);
      } else {
        return ChargeLocations.withBadRequestError(404);
      }
    } on DioException catch (dioexception) {
      if (dioexception.response == null) {
        return ChargeLocations.withConnexionError(404);
      } else {
        if (dioexception.response!.statusCode == 400) {
          return ChargeLocations.withBadRequestError(
              dioexception.response!.statusCode!);
        } else if (dioexception.response!.statusCode == 401) {
          return ChargeLocations.withUnauthorizedError(
              dioexception.response!.statusCode!);
        } else {
          return ChargeLocations.withError(204);
        }
      }
    }
  }

  
}
