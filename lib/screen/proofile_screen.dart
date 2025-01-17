import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta/Util/colors.dart';
import 'package:insta/Util/utils.dart';
import 'package:insta/widget/Follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key,required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData={};
  int postLen=0;
  int followers=0;
  int following=0;
  bool isFollwing=false;
  bool isLoading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  getData()async{
    setState(() {
      isLoading=true;
    });
    try{
      var userSnap=await FirebaseFirestore.instance.collection('users').doc(widget.uid).get();
    // get Post Link
      var postSnap=await FirebaseFirestore.instance.collection('posts').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
      postLen=postSnap.docs.length;
      userData=userSnap.data()!;
      followers=userSnap.data()!['followers'].length;
      following=userSnap.data()!['following'].length;
      isFollwing=userSnap.data()!['followers'].contains(FirebaseAuth.instance.currentUser!.uid);
    setState(() {

    });
    }
        catch(e){
          showSnackBar(context, e.toString());
        }
    setState(() {
      isLoading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return isLoading?const Center(child: CircularProgressIndicator(),):Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text('Username'),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.cyan,
                      backgroundImage: NetworkImage(userData['photoURL']),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildStatColumn(postLen, 'posts'),
                              buildStatColumn(followers, 'followers'),
                              buildStatColumn(following, 'following'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FirebaseAuth.instance.currentUser!.uid==widget.uid?
                              FollowButton(
                                  backGroundColor: mobileBackgroundColor,
                                  textColor: primaryColor,
                                  borderColor: Colors.grey,
                                  text: 'Edit Profile',
                                  function:(){}):
                                  isFollwing? FollowButton(
                                      backGroundColor: Colors.white,
                                      textColor: Colors.black,
                                      borderColor: Colors.grey,
                                      text: 'unfollow',
                                      function:(){}): FollowButton(
                                      backGroundColor: Colors.blue,
                                      textColor: Colors.white,
                                      borderColor: Colors.grey,
                                      text: 'Folllow',
                                      function:(){})
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top:15),
                  child:Text(userData['username'],style:TextStyle(
                    fontWeight: FontWeight.bold
                  ))
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top:1),
                    child:Text(userData['bio']),
                ),


              ],
            ),
          ),
          Divider(),
        FutureBuilder(
          future: FirebaseFirestore.instance.collection('posts').where('uid',isEqualTo: widget.uid).get(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            return GridView.builder(
              shrinkWrap: true,
                itemCount: (snapshot.data! as dynamic).docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 1.5,
                    childAspectRatio: 1),
              itemBuilder: (context,index){
                DocumentSnapshot snap=(snapshot.data! as dynamic).docs[index];
                return Container(
                  child:Image(
                    image:
                    NetworkImage(snap['postUrl']),
                 fit: BoxFit.cover,
                  ),

                );
              },

            );
          }

          )
        ],
      ),
    );


  }
  Column buildStatColumn(int num,String label){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(num.toString(),style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold
        ),),
        Container(
          margin: const EdgeInsets.only(top: 2),
          child: Text(label,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
          ),),
        ),
      ],
    );
  }
}
