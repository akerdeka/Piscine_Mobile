class CityModel {
  final double longitude;
  final double latitude;

  final String name;
  final String region;
  final String country;

  const CityModel(
      {required this.name,
      required this.country,
      required this.region,
      this.longitude = 0,
      this.latitude = 0});
}
