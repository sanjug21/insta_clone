import 'dart:typed_data';
import 'package:insta/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/Util/colors.dart';
import 'package:insta/Util/utils.dart';
import 'package:insta/resources/auth_method.dart';
import 'package:insta/widget/text_field_input.dart';

import '../responsive/mobileScreenLayout.dart';
import '../responsive/webScreenLayout.dart';
import '../responsive/responsive_layout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  final TextEditingController bioController=TextEditingController();
  final TextEditingController usernameController=TextEditingController();
  Uint8List? _image;
  bool isLoading=false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    usernameController.dispose();

  }

  void signup()async{
    setState(() {
      isLoading=true;
    });
    String res=await  AuthMethod().signUpUser(
        username: usernameController.text,
        password: passwordController.text,
        bio: bioController.text,
        email: emailController.text,
        file: _image);

    if(res =='Success!'){
      Navigator.pushReplacement(context, MaterialPageRoute(builder:
          (context)=> const ResponsiveLayout(
            mobileScreen: Mobile() ,
            webScreen: Web(),)));
    }
    else{
      showSnackBar(context, res);
      setState(() {
        isLoading=false;
      });

    }
    //print(res);
  }


  void selectImage()async{
 Uint8List im=await pickImage(ImageSource.gallery);
 setState(() {
   _image=im;
 });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20,),
                  // Flexible(flex: 1,child: Container(),),
                  Image.asset('image/2.png',height: 64,),
                  const SizedBox(height: 50,),
                  Stack(
                    children: [
                      _image!=null?CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!))
                      : const CircleAvatar(
                        radius: 64,
                        backgroundImage: AssetImage('image/de.png'),
                      ),
                      Positioned(
                        bottom: -10,
                          left: 80,
                          child: IconButton(
                              onPressed: selectImage,
                              icon:const Icon(Icons.add_a_photo))),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  TextFieldInput(
                      textEditingController: usernameController,
                      hintText: 'Enter Your User Name',
                      textInputType:TextInputType.text),

                  const SizedBox(height: 10,),
                  TextFieldInput(
                      textEditingController: emailController,
                      hintText: 'Enter Your E-mail',
                      textInputType:TextInputType.emailAddress),
                  const SizedBox(height: 10,),
                  TextFieldInput(
                    textEditingController: passwordController,
                    hintText: 'Enter Your Password',
                    textInputType:TextInputType.text,
                    isPass: true,),
                  const SizedBox(height: 10,),

                  TextFieldInput(
                      textEditingController: bioController,
                      hintText: 'Enter Your Bio',
                      textInputType:TextInputType.text),
                  const SizedBox(height: 20,),
                  InkWell(
                    focusColor: Colors.redAccent,
                    highlightColor: Colors.green,

                    splashColor: Colors.yellow,

                    onTap: () async {
                      signup();
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: const ShapeDecoration(
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(4)),
                        ),
                        color: Colors.blue,
                      ),
                      child: isLoading ? const Center(child: CircularProgressIndicator(color: primaryColor,),):const Text('Create Account'),
                    ),
                  ),

                  // Flexible(flex: 1,child: Container(),),
                  const SizedBox(height: 150,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text("Already have an account? "),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: const Text('Login',style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );}}