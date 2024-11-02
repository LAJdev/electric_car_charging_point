class ChargeLocation {
  String address;
  String city;
  String country;
  double latitude;
  double longitude;
  Evses evses;

  ChargeLocation({
    required this.address,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.evses,
  });

  factory ChargeLocation.fromJson(Map<String, dynamic> json) {
    return ChargeLocation(
      address: json["address"] ?? '',
      city: json["city"] ?? '',
      country: json["country"] ?? '',
      latitude: json["latitude"] ?? '',
      longitude: json["longitude"] ?? '',
      evses: Evses.fromJson(json["evses"] ?? []),
    );
  }
}

class Evse {
  String evseId;
  String status;
  String connectorType;
  String powerType;
  Evse(
      {required this.evseId,
      required this.status,
      required this.connectorType,
      required this.powerType});

  factory Evse.fromJson(Map<String, dynamic> json) {
    return Evse(
        evseId: json["evseId"] ?? '',
        status: json["status"] ?? '',
        connectorType: json["connectorType"] ?? '',
        powerType: json["powerType"] ?? '');
  }
}

class Evses {
  List<Evse> evses;
  bool? isavailable;
  Evses({required this.evses, required this.isavailable});

  factory Evses.fromJson(List<dynamic> json) {
    List<Evse>? listevse = json.map((jsonEvse) {
      return Evse.fromJson(jsonEvse);
    }).toList();

    return Evses(evses: listevse, isavailable: null);
  }
}

class ChargeLocations {
  List<ChargeLocation>? chargelocations;
  int? statuscode;
  ChargeLocations({this.chargelocations, this.statuscode});

  factory ChargeLocations.fromJson(
      List<dynamic> json, int maximumlocations, int code) {
    late List<ChargeLocation> listchargelocation;

    listchargelocation = json.map((jsonchargelocation) {
      return ChargeLocation.fromJson(jsonchargelocation);
    }).toList();

    return ChargeLocations(
        chargelocations: listchargelocation.sublist(0, maximumlocations),
        statuscode: code);
  }

  ChargeLocations.success(
      int code, List<ChargeLocation> listchargelocation,
      ) {
    statuscode = code;
    chargelocations = listchargelocation;
  }

  ChargeLocations.withUnauthorizedError(int code) {
    statuscode = code;
  }

  ChargeLocations.withBadRequestError(int code) {
    statuscode = code;
  }

  ChargeLocations.withConnexionError(int code) {
    statuscode = code;
  }

  ChargeLocations.withError(int code) {
    statuscode = code;
  }
}

