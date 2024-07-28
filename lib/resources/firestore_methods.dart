import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta/model/post.dart';
import 'package:insta/resources/Storagemethods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods{
  final FirebaseFirestore firestore=FirebaseFirestore.instance;
  Future<String> uploadPost(
      String description,
      Uint8List  file,
      String uid,
      String username,
      String profImage
      )async{
    String res="Some error occured";
    try{
    String photoUrl=await StorageMethod().uploadImageToStorage('posts', file, true);
    String postId=const Uuid().v1();
    Post post=Post(
        description: description,
        uid: uid,
        username: username,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        postId: postId,
        profImage: profImage,
        likes: [],
        );

    firestore.collection('posts').doc(postId).set(post.toJson());
    res="success";
    }
    catch(e){
    res=e.toString();
    }
    return res;
  }
  Future<void> likePost(String postId, String uid, List likes)async{
    try{
      if(likes.contains(uid)){
       await firestore.collection('posts').doc(postId).update(
            {'likes': FieldValue.arrayRemove([uid])});
      }
      else{
       await firestore.collection('posts').doc(postId).update(
            {'likes': FieldValue.arrayUnion([uid])});
      }
    }catch(e){
      print(e.toString());
    }
  }
  Future<void> postComment(String postId,String text,String uid,String name,String profilepic)async{
  try{
  if(text.isNotEmpty){
    String commentId=const Uuid().v1();
   await firestore.collection('posts').doc(postId).collection('comments').doc(commentId).set(
        {
          'profilepic':profilepic,
          'name':name,
          'uid':uid,
          'text':text,
          'commentId':commentId,
          'datePublished':DateTime.now()



        });
  }
  else{
    print('Text is empty');
  }
  }catch(e){
    print(e.toString());
  }
  }
  Future<void> deletePost(String postId)async{
    try{
      await firestore.collection('posts').doc(postId).delete();
    }catch(e){
  print(e.toString());
    }
  }

}