class CategoryModel {
  final int id;
  final String name;
  final String description;
  final String photo;
  final String value;
  final String nature;
  final String type;
  CategoryModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.photo,
      required this.nature,
      required this.value,
      required this.type});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      photo: json['photo'] as String,
      nature: json['nature'] as String,
      value: json['value'] as String,
      type: json['type'] as String,
    );
  }
}
