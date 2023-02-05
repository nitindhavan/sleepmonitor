import 'package:flutter/material.dart';
import 'package:sleepmonitor/screens/home.dart';
import 'package:sleepmonitor/screens/register.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Recommendations extends StatefulWidget {
  const Recommendations({Key? key}) : super(key: key);

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff5f259f),
        appBar: AppBar(title: Text(local.sleepRecommendations,softWrap: true,maxLines: 3,textAlign: TextAlign.start,style: TextStyle(fontSize: 16),),toolbarHeight: 80,elevation: 0,),
        body: Card(
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
          child: Column(
            children: [
              Container(margin: EdgeInsets.all(24),width: double.infinity,child: Text(local.sleepRecommendationsBrief,style: TextStyle(color: Colors.black,fontSize: 16,))),
            ],
          ),
        ),
      ),
    );
  }
}
