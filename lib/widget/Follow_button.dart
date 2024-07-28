import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
 final Function()? function;
 final Color backGroundColor;
 final Color borderColor;
 final String text;
 final Color textColor;
  const FollowButton({
    super.key,
    required this.backGroundColor,
    required this.textColor,
    required this.borderColor,
    required this.text,
    this.function
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      child: TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
            color: backGroundColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(5),

          ),
          alignment: Alignment.center,
          width: 300,
          height: 27,
          child: Text(text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }
}
