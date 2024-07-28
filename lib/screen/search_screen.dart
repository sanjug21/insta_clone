import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:insta/Util/colors.dart';
import 'package:insta/screen/proofile_screen.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final TextEditingController searchContoller=TextEditingController();
  bool isShowUser=false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  searchContoller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: searchContoller,
          decoration: const InputDecoration(
            labelText: 'Search users',
          ),
          onFieldSubmitted: (String _){
            setState(() {
              isShowUser=true;
            });
          },
        ),
      ),
      body: isShowUser?FutureBuilder(
        future: FirebaseFirestore.instance.collection('users').
          where('username',isGreaterThanOrEqualTo: searchContoller.text).get(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(),);
          }
          return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context,index){
                return InkWell(
                  onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ProfileScreen(uid: (snapshot.data! as dynamic).docs[index]['uid']),),),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage((snapshot.data! as dynamic).docs[index]['photoURL']),
                    ),
                    title: Text((snapshot.data! as dynamic).docs[index]['username']),
                  ),
                );
              }
          );
        },
      ):FutureBuilder(
        future: FirebaseFirestore.instance.collection('posts').get(),
          builder: (context,snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(),);
          }
          else{
            return StaggeredGridView.countBuilder(
              crossAxisCount: 3,
                itemCount: (snapshot.data! as dynamic).docs.length,
               itemBuilder: (context,index)=>Image.network(
                   (snapshot.data! as dynamic).docs[index]['postUrl']
               ),
              staggeredTileBuilder: (index)=>StaggeredTile.count((index%7==0)?2:1,(index%7==0)?2:1,),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            );
          }
          },
   
      )
    );
  }
}
