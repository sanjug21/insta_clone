
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:insta/screen/feed_screen.dart';
import 'package:insta/screen/post_screen.dart';
import 'package:insta/screen/proofile_screen.dart';
import 'package:insta/screen/search_screen.dart';

const webScreenSize=600;
 List<Widget> homeScreenItems=[
   FeedScreeen(),
SearchScreen(),
  AddPost(),
Center(child: Text('favorite')),
   ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,)
];