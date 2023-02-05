import 'package:flutter/material.dart';
import 'package:sleepmonitor/models/Survey.dart';
import 'package:sleepmonitor/screens/home.dart';
import 'package:sleepmonitor/screens/register.dart';
import 'package:sleepmonitor/screens/report.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({Key? key,required this.answerList,required this.name,required this.title, required this.week}) : super(key: key);

  final List<int> answerList;
  final String name;

  final String title;
  final String week;
  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context);
    Future.delayed(Duration(seconds: 1)).then((value) {
      var reference=FirebaseDatabase.instance.ref('surveys');
      Survey survey=Survey(FirebaseAuth.instance.currentUser!.uid, reference.push().key!, widget.week, widget.answerList);
      reference.child(survey.id).set(survey.toMap()).then((value){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ReportScreen(answerList: widget.answerList,name: widget.name,)));
      });
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffebe8f0),
        appBar: AppBar(title: Text(widget.title),toolbarHeight: 80,),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(margin: EdgeInsets.all(24),width: double.infinity,child: Text(local.thanksForSubmission,style: TextStyle(color: Colors.black,fontSize: 16),textAlign: TextAlign.center,)),
            SizedBox(height: 16,),
            CircularProgressIndicator(color: Color(0xff5f259f),)
    ]
    ),
      ),
    );
  }
}
