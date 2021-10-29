class CityWithCategoryModel {
  final int id;
  final String name;
  final String created;
  final List<dynamic> categories;
  CityWithCategoryModel(
      {required this.id,
      required this.created,
      required this.name,
      required this.categories});

  factory CityWithCategoryModel.fromJson(Map<String, dynamic> json) {
    return CityWithCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      created: json['created'] as String,
      categories: json['categories'] as List<dynamic>,
    );
  }
}
