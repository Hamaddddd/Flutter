
import 'package:ch8/colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onpress;
  const Button({Key? key ,  required this.title ,  this.color = Colors.blue, required this.onpress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),

        child: InkWell(
          onTap: onpress,
          child: Container(

            alignment: Alignment.center,
            height: 70,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color
            ),

            child: Text(title,style: main_text,),

          ),
        ),
      ),
    );
  }
}
