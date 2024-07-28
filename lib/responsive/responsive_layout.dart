import 'package:flutter/material.dart';
import 'package:insta/Util/global_variable.dart';
import 'package:insta/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreen;
  final Widget mobileScreen;
  const ResponsiveLayout(
      {super.key, required this.mobileScreen, required this.webScreen});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState(){
    super.initState();
    addData();
  }

  addData() async {
    UserProvider userProvider = await
    Provider.of<UserProvider>(context, listen: false);
     userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          return widget.webScreen;
        }
        return widget.mobileScreen;
      },
    );
  }
}
