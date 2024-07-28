import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta/Util/colors.dart';
import 'package:insta/resources/firestore_methods.dart';
import 'package:insta/widget/Comment_card.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../providers/user_provider.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({super.key,required this.snap});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController commentControler=TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  commentControler.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final User user = Provider.of<UserProvider>(context).getUser;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,

        centerTitle: false,
        title: const Text('Comments'),
      ),
      body:StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').doc(widget.snap['postId']).collection('comments').orderBy('datePublished',descending: true).snapshots() ,
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          return ListView.builder(
              itemCount:( snapshot.data as dynamic).docs.length,
              itemBuilder: (context,index)=> CommentCard(
                snap: (snapshot.data! as dynamic).docs[index].data()
              ));
        },
      ),


      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          padding:const EdgeInsets.only(left: 16, right: 8) ,
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL),
                radius: 18,
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16,right: 8),
                  child: TextField(
                    controller: commentControler,
                    decoration: InputDecoration(
                      hintText: 'Comment as ${user.username}',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: ()async{
                 await FirestoreMethods().postComment(
                     widget.snap['postId'],
                     commentControler.text,
                     user.uid,user.username,user.photoURL );
                 setState(() {
                   commentControler.text="";
                 });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical:8,horizontal: 8 ),
                  child: const Text('Post',
                  style: TextStyle(
                    color: Colors.cyan
                      ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
