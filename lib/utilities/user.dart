class User {
  String name;
  String location;
  String phoneNumber;
  String? profileImagePath;
  String email;

  User({
    required this.name,
    required this.location,
    required this.phoneNumber,
    required this.email,
    this.profileImagePath,
  });
}
