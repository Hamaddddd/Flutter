
import 'package:ch8/colors.dart';
import 'package:ch8/components/Button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var user_input = '';
  var answer = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
          child: Column(
            children: [

              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Text(user_input.toString(),style: view_text,)
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(answer.toString(),style: view_text,),
                      ],
              ),
                  ),
              ),


              Expanded(
                flex: 2,
                child: Column(
              children: [

                Row( //first row
              children: [
                Button(title: "AC",color: blue, onpress: () {
                  user_input = '';
                  answer = '';
                  setState(() {

                  });
                },),
              Button(title: "^",color: blue, onpress: () {
                user_input += '^';
                setState(() {

                });
              },),
              Button(title: "%",color: blue, onpress: () {
                user_input += '%';
                setState(() {

                });
              },),
              Button(title: "/",color: grey700, onpress: () {
                user_input += '/';
                setState(() {

                });
              },),
            ],
          ),
                Row( //second row
          children: [
            Button(title: "7",color: blue, onpress: () {
              user_input += '7';
              setState(() {

              });
            },),
            Button(title: "8",color: blue, onpress: () {
              user_input += '8';
              setState(() {

              });
            },),
            Button(title: "9",color: blue, onpress: () {
              user_input += '9';
              setState(() {

              });
            },),
            Button(title: "x",color: grey700, onpress: () {
              user_input += 'x';
              setState(() {

              });
            },),
          ],
        ),
                Row( //third row
          children: [
            Button(title: "4",color: blue, onpress: () {
              user_input += '4';
              setState(() {

              });
            },),
            Button(title: "5",color: blue, onpress: () {
              user_input += '5';
              setState(() {

              });
            },),
            Button(title: "6",color: blue, onpress: () {
              user_input += '6';
              setState(() {

              });
            },),
            Button(title: "-",color: grey700, onpress: () {
              user_input += '-';
              setState(() {

              });
            },),
          ],
        ),
                Row( //fourth row
          children: [
            Button(title: "1",color: blue, onpress: () {
              user_input += '1';
              setState(() {

              });
            },),
            Button(title: "2",color: blue, onpress: () {
              user_input += '2';
              setState(() {

              });
            },),
            Button(title: "3",color: blue, onpress: () {
              user_input += '3';
              setState(() {

              });
            },),
            Button(title: "+",color: grey700, onpress: () {
              user_input += '+';
              setState(() {

              });
            },),
          ],
        ),
                Row( //fifth row
          children: [
            Button(title: "0",color: blue, onpress: () {
              user_input += '0';
              setState(() {

              });
            },),
            Button(title: ".",color: blue, onpress: () {
              user_input += '.';
              setState(() {

              });
            },),
            Button(title: "DEL",color: blue, onpress: () {
              user_input = user_input.substring( 0 , user_input.length - 1 );
              setState(() {

              });
            },),
            Button(title: "=",color: grey700, onpress: () {
              equalButton_Press();
              setState(() {

              });
            },),

          ],
        ),

        ],

      ),

              ),
            ],

          )
      ),
    );

  }


//methods_here
  void equalButton_Press() {

    final String final_user_input = user_input.replaceAll( 'x' , '*' );

    Parser p = Parser();
    Expression exp = p.parse(final_user_input);
    ContextModel contextModel = ContextModel();
    //answer being evaluated now
    double evaluated_exp = exp.evaluate(EvaluationType.REAL, ContextModel());
    answer = evaluated_exp.toString();

  }

}
