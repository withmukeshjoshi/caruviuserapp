class Profile {
  final int id;
  final String fullName;
  final String profilePicture;
  final String emailAddress;
  final String phoneNumber;
  final String businessName;
  final String address;
  final String userType;
  final String banned;
  final dynamic lastVisit;
  final String token;
  final dynamic created;

  const Profile({
    required this.id,
    required this.fullName,
    required this.profilePicture,
    required this.emailAddress,
    required this.phoneNumber,
    required this.businessName,
    required this.address,
    required this.userType,
    required this.banned,
    required this.lastVisit,
    required this.token,
    required this.created,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as int,
      fullName: json['fullName'] as String,
      profilePicture: json['profilePicture'] as String,
      emailAddress: json['emailAddress'] as String,
      phoneNumber: json['phoneNumber'] as String,
      businessName: json['businessName'] as String,
      address: json['address'] as String,
      userType: json['userType'] as String,
      banned: json['banned'] as String,
      lastVisit: json['lastVisit'] as dynamic,
      token: json['token'] as String,
      created: json['created'] as dynamic,
    );
  }
}
