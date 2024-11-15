import 'package:flutter/cupertino.dart';
import 'package:sushi_shukan_app/utilities/user.dart';

class AppStateManager extends ChangeNotifier {
  final UserInfo _user = UserInfo(
    name: "Daisuke Nakazawa",
    location: "West Village, NY",
    phoneNumber: "+1 212-555-1234",
    email: "info@sushishukan.com",
  );

  UserInfo get user => _user;

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
