class CityModel {
  final int id;
  final String name;
  final String state;
  final String created;
  CityModel(
      {required this.id,
      required this.created,
      required this.name,
      required this.state});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] as int,
      name: json['name'] as String,
      state: json['state'] as String,
      created: json['created'] as String,
    );
  }
}
