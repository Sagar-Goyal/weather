class AddressModel {
  AddressModel({
    required this.city,
    required this.state,
    required this.country,
  });

  String city;
  String state;
  String country;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        city: json["features"][0]["properties"]["city"],
        state: json["features"][0]["properties"]["state"],
        country: json["features"][0]["properties"]["country"],
      );
}
