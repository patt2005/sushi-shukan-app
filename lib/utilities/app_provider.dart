import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Future<String?> _fetchApi() async {
    const apiUrl = "https://pattt2005.pythonanywhere.com/sushi/";
    final response = await Dio().get(apiUrl);
    final data = (response.data as Map<String, dynamic>)["Url"];
    if (data != null) {
      return data;
    }
    return null;
  }

  Future<void> _writeData(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("url", url);
  }

  Future<String?> _readData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("url");
  }

  Future<String?> onFirstAppOpen() async {
    final url = await _fetchApi();
    if (url != null) {
      await _writeData(url);
      return url;
    }
    return null;
  }

  Future<String?> initApp() async {
    final data = await _readData();
    return data;
  }

  Future<bool> isFirstOpen() async {
    final prefs = await SharedPreferences.getInstance();
    bool? opened = prefs.getBool("open");
    await prefs.setBool("open", true);
    if (opened == null) {
      return true;
    }
    return false;
  }
}
