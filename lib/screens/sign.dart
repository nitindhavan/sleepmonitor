import 'package:flutter/material.dart';
import 'package:sleepmonitor/screens/introduction.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sleepmonitor/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';

class Sign extends StatefulWidget {
  const Sign({Key? key}) : super(key: key);

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff5f259f),
        appBar: AppBar(title: Text(local.signIn,textAlign: TextAlign.center,),toolbarHeight: 80,centerTitle: true,elevation: 0,),
        body: Card(
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  alignment: Alignment.topRight,
                  child: GestureDetector(onTap:() async {
                    var sharep=await SharedPreferences.getInstance();
                    setState(() {
                      sharep.getString('languagecode')=='hi' ? sharep.setString('languagecode','en'): sharep.setString('languagecode','hi');
                      MyApp.of(context)?.setLocale(Locale.fromSubtags(languageCode: sharep.getString('languagecode')??'hi '));
                    });
                  },child: Container(height: 50,width: 50,decoration: BoxDecoration(color: Color(0xff5f259f),borderRadius: BorderRadius.circular(20)),child: Icon(Icons.language,color: Colors.white,),)),
                ),
                // Text(local.sleepMonitor,style: TextStyle(fontSize: 32,color: Colors.black,fontWeight: FontWeight.bold),),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Image.asset(
                      'assets/icon.png',
                      height: 200,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    signup(context);
                  },
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Color(0xff5f259f),
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(margin: EdgeInsets.only(left: 8,right: 8),child: Icon(Icons.login,color: Colors.white,)),
                          Text(local.signInWithGoogle,style: TextStyle(color: Colors.white),textAlign: TextAlign.start,)
                        ]),
                  ),
                ),
                SizedBox(height: 24,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signup(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
      'email',
    ],);
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await FirebaseAuth.instance.signInWithCredential(authCredential);
      User? user = result.user;

      if (result != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Introduction()));
      }  // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }
}
