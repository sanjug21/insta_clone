import 'package:flutter/widgets.dart';
import 'package:insta/model/user.dart';
import 'package:insta/resources/auth_method.dart';


class UserProvider with ChangeNotifier {
  // final List<dynamic> ls=[];
  User? _user;
  final AuthMethod _authMethods = AuthMethod();

  User get getUser {
    // if(_user==null){
    //   return User(email: " ", photoURL: " ", uid: " ", bio: " ", username: " j", followers:  ls, following: ls);
    // }
    return _user!;
  }

  Future<void> refreshUser() async {
     _user = await _authMethods.getUserDetails();
    // _user = user;
    notifyListeners();
  }
}