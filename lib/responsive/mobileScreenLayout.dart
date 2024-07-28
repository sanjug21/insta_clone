import 'package:flutter/material.dart';
import 'package:insta/Util/colors.dart';
import 'package:insta/Util/global_variable.dart';
// import 'package:provider/provider.dart';
//
// import '../model/user.dart';
// import '../providers/user_provider.dart';

class Mobile extends StatefulWidget {
  const Mobile({super.key});

  @override
  State<Mobile> createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  // late Map <String,dynamic> username;

//   @override
//   void initState(){
//     super.initState();
//     getUsername();
//   }
// void getUsername() async{
//
//    DocumentSnapshot snap=await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
//     print(snap.data());
//    setState(() {
//      username=(snap.data() as Map<String,dynamic>);
//    });
// }
late PageController pageController;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController=PageController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
  int page=0;
  void navigationTapped(int _page){
  pageController.jumpToPage(_page);
  }
  void OnPageChanged(int _page){
    setState(() {
      page=_page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // User user=Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body:PageView(
        children:homeScreenItems,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: OnPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: page==0?primaryColor:secondaryColor,),
            label: '',
            backgroundColor: mobileBackgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,color: page==1?primaryColor:secondaryColor,),
            label: '',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle,color: page==2?primaryColor:secondaryColor,),
            label: '',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,color: page==3?primaryColor:secondaryColor,),
            label: '',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,color: page==4?primaryColor:secondaryColor,),
            label: '',

          ),
        ],
      onTap: navigationTapped,
      ),
    );
  }
}
