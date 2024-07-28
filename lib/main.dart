
import 'package:insta/providers/user_provider.dart';
import 'package:insta/responsive/webScreenLayout.dart';
import 'package:insta/responsive/mobileScreenLayout.dart';
import 'package:insta/responsive/responsive_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insta/Util/colors.dart';
import 'package:insta/screen/login_screen.dart';
import 'package:provider/provider.dart';
// import 'package:insta/screen/signup_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
  //   options: const FirebaseOptions(
  //
  //       apiKey: "AIzaSyBO0pLpbgF6GpVlU5s_fd-JFAhlkeHMoI8",
  //       projectId: "insta-12d54",
  //       storageBucket: "insta-12d54.appspot.com",
  //       messagingSenderId: "6265053650",
  //       appId: "1:6265053650:web:ebb6bdc10ceb4408ade80b")
   );
  runApp(const MyApp());}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram',
        theme: ThemeData.dark(useMaterial3: true,).copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        // theme: ThemeData.dark(useMaterial3: true).copyWith(
        //   scaffoldBackgroundColor: mobileBackgroundColor,
        // ),
        // home: const ResponsiveLayout(mobileScreen: Mobile() ,webScreen: Web(),),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreen: Mobile(), webScreen: Web(),);
              }
              else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}',));
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: primaryColor,),);
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }

}