import 'package:flutter/material.dart';
import 'package:sleepmonitor/screens/home.dart';
import 'package:sleepmonitor/screens/sign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context);
    Future.delayed(Duration(seconds: 0)).then((value) {
      if(FirebaseAuth.instance.currentUser==null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Sign()));
      }else{
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
    return Scaffold(
      backgroundColor: Color(0xff5f259f),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200)
          ),
          padding: EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: Image.asset(
              'icon.png',
              height: 170,
              width: 170,
            ),
          ),
        ),
      ),
    );
  }
}
