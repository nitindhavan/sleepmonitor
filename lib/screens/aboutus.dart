import 'package:flutter/material.dart';
import 'package:sleepmonitor/screens/home.dart';
import 'package:sleepmonitor/screens/register.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff5f259f),
        appBar: AppBar(title: Text(local.aboutUs,textAlign: TextAlign.center,),toolbarHeight: 80,centerTitle: true,elevation: 0,),
        body: Card(

          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
          child: Column(
            children: [
              Container(margin: EdgeInsets.all(24),width: double.infinity,child: Text(local.aboutUsBrief,style: TextStyle(fontSize: 16),)),
            ],
          ),
        ),
      ),
    );
  }
}
