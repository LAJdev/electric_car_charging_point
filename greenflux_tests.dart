import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;

  Response<dynamic> response;

  group("apichargelocation", () {
    const baseUrl = url;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: baseUrl));
      dioAdapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
      dio.httpClientAdapter = dioAdapter;
    });

    test("Get charge location sucess (200) test", () async {
      const chargelocationInformation = <String, dynamic>{
        'address': "Address809 13",
        'city': 'Amsterdam',
        'country': 'NLD',
        'latitude': '52.3102',
        'longitude': '4.8822',
        'evses': [
          {
            'evseId': 'NL*GFX*EPP001451*1',
            'status': 'CHARGING',
            'connectorType': 'IEC_62196_T2',
            'powerType': 'AC_3_PHASE'
          }
        ]
      };

      dioAdapter.onGet(
          url, (server) => server.reply(200, chargelocationInformation));

      response = await dio.get(
        url,
        queryParameters: {
          "q": "amsterdam",
        },
        options: Options(
          headers: {
            "Authorization": apiKey,
          },
        ),
      );

      expect(response.data, chargelocationInformation);
    });

    test("Get charge location failure (401) test", () async {
      dioAdapter.onGet(
          url,
          (server) => server.throws(
                401,
                DioException(requestOptions: RequestOptions(path: baseUrl)),
              ));

      expect(
          () async => await dio.get(
                baseUrl,
                queryParameters: {
                  "q": "amsterdam",
                },
                options: Options(
                  headers: {
                    "Authorization": "apiKey",
                  },
                ),
              ),
          throwsA(isA<DioException>()));
    });

    test("Get charge location failure (400) test", () async {
      dioAdapter.onGet(
          url,
          (server) => server.throws(
                400,
                DioException(requestOptions: RequestOptions(path: baseUrl)),
              ));

      expect(
          () async => await dio.get(
                baseUrl,
                queryParameters: {
                  "q": "am",
                },
                options: Options(
                  headers: {
                    "Authorization": apiKey,
                  },
                ),
              ),
          throwsA(isA<DioException>()));
    });
  });

  group("fromjson", () {
    test("return correct charging location", () {
      expect(
          ChargeLocation.fromJson(<String, dynamic>{
            "address": "Address534 1",
            "city": "Amsterdam",
            "country": "NED",
            "latitude": 19.06593,
            "longitude": -98.13851,
          }),
          isA<ChargeLocation>()
              .having((p0) => p0.address, "address", "Address534 1")
              .having((p0) => p0.city, "city", "Amsterdam")
              .having((p0) => p0.country, "country", "NED")
              .having((p0) => p0.latitude, "latitude", 19.06593)
              .having((p0) => p0.longitude, "longitude", -98.13851));
    });
    test("return correct Evse", () {
      expect(
          Evse.fromJson(<String, dynamic>{
            "evseId": "NL-GFX-EHSP-CHRG-20220126-1337-1",
            "status": "AVAILABLE",
            "connectorType": "IEC_62196_T2",
            "powerType": "AC_1_PHASE",
          }),
          isA<Evse>()
              .having((p0) => p0.evseId, "evseId",
                  "NL-GFX-EHSP-CHRG-20220126-1337-1")
              .having((p0) => p0.status, "status", "AVAILABLE")
              .having((p0) => p0.connectorType, "connectorType", "IEC_62196_T2")
              .having((p0) => p0.powerType, "powerType", "AC_1_PHASE"));
    });
  });
}
