import 'package:cloud_firestore/cloud_firestore.dart';


class User{
  final String email;
  final String uid;
  final String username;
  final String bio;
  final String photoURL;
  final List following;
  final List followers;
  const User({
    required this.email,
    required this.photoURL,
    required this.uid,
    required this.bio,
    required this.username,
    required this.followers,
    required this.following
});
Map<String,dynamic> toJson()=>{
 "email":email,
  "uid":uid,
  "username":username,
  "bio":bio,
  "photoURL":photoURL,
  "followers":followers,
  "followings":following
};

static User fromSnap(DocumentSnapshot snap){
  var snapshot =snap.data() as Map<String, dynamic>;
  print(snapshot);
  print(snapshot['username']);


   return User(
       email: snapshot['email'],
       photoURL: snapshot['photoURL'],
       uid: snapshot['uid'],
       bio: snapshot['bio'],
       username: snapshot['username'],
       followers: snapshot['followers'],
       following: snapshot['following']);
}

}