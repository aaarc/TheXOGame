import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_xo_game/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'logic_for_xo.dart';



void main() {
  runApp(MaterialApp(
      title: 'THE XO GAME',
      debugShowCheckedModeBanner: false,
      home:const Login_Page()));
}

class main_page extends StatefulWidget {

  const main_page({Key? key}) : super(key: key);

  @override
  State<main_page> createState() => _main_pageState();
}

class _main_pageState extends State<main_page> {

   GoogleSignInAccount? acc;
  late List arr=[" "," "," "," "," "," "," "," "," "];
  brains br = new brains();
  int wins=0;
  int loss=0;
  int draw=0;
  late var a;
  bool signed_in_=false;
  String game_state =",What did you do";


  void restart_game()
  {
    arr=List.filled(9, null, growable: false);
    for(int i=0;i<9;i++)
      {
        arr[i]=" ";
      }
  }


  @override
  void initState() {
    restart_game();
    try{
      GoogleSignIn().signInSilently().then((value) => acc);
      a=GoogleSignIn().currentUser?.displayName;
      print("SignIn Successful,in main page now");
      signed_in_=true;
    }
    catch(e)
    {
      print(e);
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:Drawer(backgroundColor: Colors.amberAccent,child: Column(
        children: [
          SizedBox(height: 40,),
          Text("The XO Game",style: GoogleFonts.rajdhani(
          fontSize: 50,
            fontWeight:FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("This App/Game Was made by\n Adithya Narayan Samal\n20MID0228\n\nFor the ExtraCurricular Course\nIOS Development EXC1084\nUnder the Guidence of \nProfessor Rajkumar R\n",style: GoogleFonts.rajdhani(
              fontSize: 22,
              fontWeight:FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),),
          ),

        Padding(
          padding: const EdgeInsets.all(55),
          child: FlatButton(onPressed: ()async {

            if(signed_in_)
              {
                try {
                  await GoogleSignIn().disconnect();
                  signed_in_ = false;
                  const snackBar = SnackBar(
                    content: Text('Logged out from Google'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                catch(e)
            {
              print(e);
            }



              }
            Navigator.push(context, MaterialPageRoute(builder:(context)=>Login_Page() ));

          }, child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text("LOGOUT ",style: GoogleFonts.rajdhani(color: Colors.white,
            fontSize: 25,
            fontWeight:FontWeight.bold,
            fontStyle: FontStyle.italic,

          ),),Icon(Icons.logout,color: Colors.white,)],),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),color: Colors.amber,),
        )],
      ),),
      drawerDragStartBehavior:DragStartBehavior.down ,
    body:SafeArea(
      top: true,
    child: Padding(padding: const EdgeInsets.all(5.0),
      child: Center(
        child: SingleChildScrollView(child:
          Center(
            child: ConstrainedBox(constraints: BoxConstraints.loose(Size.infinite),
              child: Card(color: Colors.amberAccent,child: Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [Row(
                  children: [
                    SvgPicture.asset("assets/logo_svg.svg"),
                    SizedBox(width: 80,),
                    SvgPicture.asset("assets/SCORE.svg"),
                    SizedBox(width: 4,),
                    Text("Wins     : $wins\nLosses : $loss\nDraw   : $draw",style: GoogleFonts.rajdhani(
                      fontSize: 22,
                      fontWeight:FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),),
                  ],
                ),SizedBox(height: 35,),
                  Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FlatButton(color: Colors.amberAccent,child: Text("${arr[0]}",style: GoogleFonts.rajdhani(
                          fontSize: 38,
                          fontWeight:FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),),onPressed: (){
                          if(arr[0]==" ")
                          {arr[0]="x";
                          arr[br.mk_move(arr)]='o';
                          if(br.Chk_user_won(arr)==1)
                            {
                              wins+=1;
                              showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                                backgroundColor: Colors.amberAccent,title: Center(
                                  child: Text("YOU WON",style: GoogleFonts.rajdhani(
                                      fontSize: 38,
                                      fontWeight:FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white
                                  ),),
                                ),
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FlatButton(onPressed: (){
                                    restart_game();
                                    setState(() {});
                                    Navigator.pop(context);
                                  }, child: Text("OK",style: GoogleFonts.rajdhani(
                                      fontSize: 20,
                                      fontWeight:FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white),),
                                    color: Colors.amber,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                                ),));
                            }
                          else if(br.Chk_user_won(arr)==0)
                            {
                              loss+=1;
                              showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                                backgroundColor: Colors.amberAccent,title: Center(
                                  child: Text("YOU LOST",style: GoogleFonts.rajdhani(
                                      fontSize: 38,
                                      fontWeight:FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white
                                  ),),
                                ),
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FlatButton(onPressed: (){
                                    restart_game();
                                    setState(() {});
                                    Navigator.pop(context);
                                  }, child: Text("OK",style: GoogleFonts.rajdhani(
                                      fontSize: 20,
                                      fontWeight:FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white),),
                                    color: Colors.amber,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                                ),));
                            }
                          else if(br.Check_Game_over(arr))
                            {
                              draw+=1;
                              showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                                backgroundColor: Colors.amberAccent,title: Center(
                                  child: Text("DRAW",style: GoogleFonts.rajdhani(
                                      fontSize: 45,
                                      fontWeight:FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white
                                  ),),
                                ),
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FlatButton(onPressed: (){
                                    restart_game();
                                    setState(() {});
                                    Navigator.pop(context);
                                  }, child: Text("OK",style: GoogleFonts.rajdhani(
                                      fontSize: 20,
                                      fontWeight:FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white),),
                                    color: Colors.amber,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                                ),));
                            }
                          else
                            {
                              print("error at check the grid for xo game ");
                            }
                          setState(() {});
                       }},),
                      ),
                      SizedBox(width:5,height:80,child: ColoredBox(color: Colors.black12),),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FlatButton(color: Colors.amberAccent,child: Text("${arr[1]}",style: GoogleFonts.rajdhani(
                          fontSize: 38,
                          fontWeight:FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),),onPressed: (){
                          if(arr[1]==" ")
                          {arr[1]="x";
                          arr[br.mk_move(arr)]='o';
                          if(br.Chk_user_won(arr)==1)
                          {
                            wins+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("YOU WON",style: GoogleFonts.rajdhani(
                                    fontSize: 38,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else if(br.Chk_user_won(arr)==0)
                          {
                            loss+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("YOU LOST",style: GoogleFonts.rajdhani(
                                    fontSize: 38,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else if(br.Check_Game_over(arr))
                          {
                            draw+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("DRAW",style: GoogleFonts.rajdhani(
                                    fontSize: 45,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else
                          {
                            print("error at check the grid for xo game ");
                          }
                          setState(() {});
                          }},),
                      ),
                      SizedBox(width:5,height:80,child: ColoredBox(color: Colors.black12),),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FlatButton(color: Colors.amberAccent,child: Text("${arr[2]}",style: GoogleFonts.rajdhani(
                          fontSize: 38,
                          fontWeight:FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),),onPressed: (){
                          if(arr[2]==" ")
                          {arr[2]="x";
                          arr[br.mk_move(arr)]='o';
                          if(br.Chk_user_won(arr)==1)
                          {
                            wins+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("YOU WON",style: GoogleFonts.rajdhani(
                                    fontSize: 38,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else if(br.Chk_user_won(arr)==0)
                          {
                            loss+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("YOU LOST",style: GoogleFonts.rajdhani(
                                    fontSize: 38,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else if(br.Check_Game_over(arr))
                          {
                            draw+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("DRAW",style: GoogleFonts.rajdhani(
                                    fontSize: 45,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else
                          {
                            print("error at check the grid for xo game ");
                          }
                          setState(() {});
                          }},),
                      ),

                    ],),SizedBox(width:345,height:5,child: ColoredBox(color: Colors.black12),),
                    Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FlatButton(color: Colors.amberAccent,child: Text("${arr[3]}",style: GoogleFonts.rajdhani(
                          fontSize: 38,
                          fontWeight:FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),),onPressed: (){
                          if(arr[3]==" ")
                          {arr[3]="x";
                          arr[br.mk_move(arr)]='o';
                          if(br.Chk_user_won(arr)==1)
                          {
                            wins+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("YOU WON",style: GoogleFonts.rajdhani(
                                    fontSize: 38,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else if(br.Chk_user_won(arr)==0)
                          {
                            loss+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("YOU LOST",style: GoogleFonts.rajdhani(
                                    fontSize: 38,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else if(br.Check_Game_over(arr))
                          {
                            draw+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("DRAW",style: GoogleFonts.rajdhani(
                                    fontSize: 45,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else
                          {
                            print("error at check the grid for xo game ");
                          }
                          setState(() {});
                          }},),
                      ),
                      SizedBox(width:5,height:80,child: ColoredBox(color: Colors.black12),),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FlatButton(color: Colors.amberAccent,child: Text("${arr[4]}",style: GoogleFonts.rajdhani(
                          fontSize: 38,
                          fontWeight:FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),),onPressed: (){
                          if(arr[4]==" ")
                          {arr[4]="x";
                          arr[br.mk_move(arr)]='o';
                          if(br.Chk_user_won(arr)==1)
                          {
                            wins+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("YOU WON",style: GoogleFonts.rajdhani(
                                    fontSize: 38,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else if(br.Chk_user_won(arr)==0)
                          {
                            loss+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("YOU LOST",style: GoogleFonts.rajdhani(
                                    fontSize: 38,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else if(br.Check_Game_over(arr))
                          {
                            draw+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("DRAW",style: GoogleFonts.rajdhani(
                                    fontSize: 45,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else
                          {
                            print("error at check the grid for xo game ");
                          }
                          setState(() {});
                          }},),
                      ),
                      SizedBox(width:5,height:80,child: ColoredBox(color: Colors.black12),),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FlatButton(color: Colors.amberAccent,child: Text("${arr[5]}",style: GoogleFonts.rajdhani(
                          fontSize: 38,
                          fontWeight:FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),),onPressed: (){
                          if(arr[5]==" ")
                          {arr[5]="x";
                          arr[br.mk_move(arr)]='o';
                          if(br.Chk_user_won(arr)==1)
                          {
                            wins+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("YOU WON",style: GoogleFonts.rajdhani(
                                    fontSize: 38,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else if(br.Chk_user_won(arr)==0)
                          {
                            loss+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("YOU LOST",style: GoogleFonts.rajdhani(
                                    fontSize: 38,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else if(br.Check_Game_over(arr))
                          {
                            draw+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("DRAW",style: GoogleFonts.rajdhani(
                                    fontSize: 45,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else
                          {
                            print("error at check the grid for xo game ");
                          }
                          setState(() {});
                          }},),
                      ),


                    ],),SizedBox(width:345,height:5,child: ColoredBox(color: Colors.black12),),
                    Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FlatButton(color:Colors.amberAccent,child: Text("${arr[6]}",style: GoogleFonts.rajdhani(
                          fontSize: 38,
                          fontWeight:FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),),onPressed: (){
                          if(arr[6]==" ")
                          {arr[6]="x";
                          arr[br.mk_move(arr)]='o';
                          if(br.Chk_user_won(arr)==1)
                          {
                            wins+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("YOU WON",style: GoogleFonts.rajdhani(
                                    fontSize: 38,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else if(br.Chk_user_won(arr)==0)
                          {
                            loss+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("YOU LOST",style: GoogleFonts.rajdhani(
                                    fontSize: 38,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else if(br.Check_Game_over(arr))
                          {
                            draw+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("DRAW",style: GoogleFonts.rajdhani(
                                    fontSize: 45,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else
                          {
                            print("error at check the grid for xo game ");
                          }
                          setState(() {});
                          }},),
                      ),
                      SizedBox(width:5,height:80,child: ColoredBox(color: Colors.black12),),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FlatButton(color:Colors.amberAccent,child: Text("${arr[7]}",style: GoogleFonts.rajdhani(
                          fontSize: 38,
                          fontWeight:FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),),onPressed: (){
                          if(arr[7]==" ")
                          {arr[7]="x";
                          arr[br.mk_move(arr)]='o';
                          if(br.Chk_user_won(arr)==1)
                          {
                            wins+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("YOU WON",style: GoogleFonts.rajdhani(
                                    fontSize: 38,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else if(br.Chk_user_won(arr)==0)
                          {
                            loss+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("YOU LOST",style: GoogleFonts.rajdhani(
                                    fontSize: 38,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else if(br.Check_Game_over(arr))
                          {
                            draw+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("DRAW",style: GoogleFonts.rajdhani(
                                    fontSize: 45,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else
                          {
                            print("error at check the grid for xo game ");
                          }
                          setState(() {});
                          }},),
                      ),
                      SizedBox(width:5,height:80,child: ColoredBox(color: Colors.black12),),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FlatButton(color:Colors.amberAccent,child: Text("${arr[8]}",style: GoogleFonts.rajdhani(
                          fontSize: 38,
                          fontWeight:FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),),onPressed: (){
                          if(arr[8]==" ")
                          {arr[8]="x";
                          arr[br.mk_move(arr)]='o';
                          if(br.Chk_user_won(arr)==1)
                          {
                            wins+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("YOU WON",style: GoogleFonts.rajdhani(
                                    fontSize: 38,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else if(br.Chk_user_won(arr)==0)
                          {
                            loss+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("YOU LOST",style: GoogleFonts.rajdhani(
                                    fontSize: 38,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else if(br.Check_Game_over(arr))
                          {
                            draw+=1;
                            showDialog(context: context, builder:(context)=>AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              backgroundColor: Colors.amberAccent,title: Center(
                                child: Text("DRAW",style: GoogleFonts.rajdhani(
                                    fontSize: 45,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                ),),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(onPressed: (){
                                  restart_game();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, child: Text("OK",style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight:FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              ),));
                          }
                          else
                          {
                            print("error at check the grid for xo game ");
                          }
                          setState(() {});
                          }},),
                      ),
                    ],
                    ),
                  ],),

                SizedBox(height: 25,)
                  ,FlatButton(onPressed: (){
                    restart_game();
                    const snackBar1 = SnackBar(content: Text('Game Board has been ReSet'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar1);

                    setState(() {

                    });
                  },shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),splashColor: Colors.yellowAccent, child: SizedBox(width: 100,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(" Restart ",style: GoogleFonts.rajdhani(fontSize: 20,color: Colors.white,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                      Icon(Icons.restart_alt,color: Colors.white,)
                    ],
                  ),
                ),color: Colors.amber,),SizedBox(height: 40,)],),
              ),),
            ),
          ),

        ),
      ),
      ),
    ),backgroundColor: Colors.amberAccent,);
  }
}
