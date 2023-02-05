import 'package:flutter/material.dart';
import 'package:sleepmonitor/screens/home.dart';
import 'package:sleepmonitor/screens/register.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Introduction extends StatefulWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff5f259f),
        appBar: AppBar(title: Text(local.introduction,textAlign: TextAlign.center,),toolbarHeight: 80,centerTitle: true,elevation: 0,),
        body: Card(
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: [
                  Container(margin: EdgeInsets.all(24),width: double.infinity,child: Text(local.introductionBrief,style: TextStyle(color: Colors.black,fontSize: 16),textAlign: TextAlign.justify,)),
                  Container(margin: EdgeInsets.only(left: 24),width: double.infinity,child: Text(local.readMore,style: TextStyle(color: Colors.blue.shade900,fontSize: 18,fontWeight: FontWeight.bold),)),
                  SizedBox(height: 32,),
                  GestureDetector(
                    onTap: (){
                      checkDatabase();
                    },
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Color(0xff5f259f), borderRadius: BorderRadius.circular(32)),
                      child: Center(child: Text(local.continueText,style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                  SizedBox(height: 32,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkDatabase() async {
    FirebaseDatabase.instance.ref('users').child(FirebaseAuth.instance.currentUser!.uid).once().then((value){
      if(value.snapshot.exists){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Register()));
      }
    });
  }
}
