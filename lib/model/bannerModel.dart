class BannerModel {
  final int id;
  final String url;
  final String imageUrl;
  final String created;
  BannerModel(
      {required this.id,
      required this.created,
      required this.url,
      required this.imageUrl});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] as int,
      url: json['url'] as String,
      imageUrl: json['imageUrl'] as String,
      created: json['created'] as String,
    );
  }
}
