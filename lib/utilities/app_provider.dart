import 'package:flutter/cupertino.dart';
import 'package:sushi_shukan_app/utilities/user.dart';

class AppProvider extends ChangeNotifier {
  final User _user = User(
    name: "John Doe",
    location: "New York City, NY",
    phoneNumber: "+123 456 7890",
    email: "johndoe@gmail.com",
  );

  User get user => _user;

  void setProfileImagePath(String path) {
    _user.profileImagePath = path;
    notifyListeners();
  }

  void setUserLocation(String loc) {
    _user.location = loc;
    notifyListeners();
  }

  void setUserName(String name) {
    _user.name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    _user.email = email;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    _user.phoneNumber = phoneNumber;
    notifyListeners();
  }
}
