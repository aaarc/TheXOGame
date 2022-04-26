import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login_Page extends StatefulWidget {


  const Login_Page({Key? key}) : super(key: key);


  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  GoogleSignInAccount? acc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.amberAccent,body:
      Padding(
        padding: const EdgeInsets.all(35.0),

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [SvgPicture.asset("assets/big_logo.svg"),
            SizedBox(height: 75,),
            FlatButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>main_page()));
            },color: Colors.amber ,child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text("   Sign In as Guest    ",style: GoogleFonts.rajdhani(
                fontSize: 20,
                fontWeight:FontWeight.bold,
                fontStyle: FontStyle.italic,
              )),
            ),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
            SizedBox(height: 25,),
          FlatButton(onPressed: ()async{

            await GoogleSignIn().signIn().then((value) => acc);
            print("Sign Success");

            Navigator.push(context, MaterialPageRoute(builder: (context)=>main_page()));

            setState(() {
            });
            }, child:Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text("Sign In with Google",style: GoogleFonts.rajdhani(
              fontSize: 20,
              fontWeight:FontWeight.bold,
              fontStyle: FontStyle.italic,
          )),
            )
            ,color: Colors.amber,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))],),
        ),
      ),);
  }
}
