// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user.dart' ;
import '../providers/user_provider.dart';

class Web extends StatefulWidget {
  const Web({super.key});

  @override
  State<Web> createState() => _WebState();
}

class _WebState extends State<Web> {
  @override
  Widget build(BuildContext context) {
    User user=Provider.of<UserProvider>(context).getUser;
    return  Scaffold(
      body: Center(child: Text(user.username)),
    );
  }
}
