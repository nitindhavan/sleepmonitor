import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sleepmonitor/models/notification.dart';
import 'package:sleepmonitor/screens/aboutus.dart';
import 'package:sleepmonitor/screens/notifications.dart';
import 'package:sleepmonitor/screens/profile.dart';
import 'package:sleepmonitor/screens/recommendations.dart';
import 'package:sleepmonitor/screens/register.dart';
import 'package:sleepmonitor/screens/report.dart';
import 'package:sleepmonitor/screens/survey.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:sleepmonitor/models/Survey.dart' as model;

import 'package:sleepmonitor/models/User.dart' as user;
import 'package:shared_preferences/shared_preferences.dart';

import '../data/constants.dart';
import 'contact.dart';

import 'package:intl/intl.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool once=false;

  bool playing=false;

  bool visible=false;

  String name='Student';


  List<String> notifications=[];

  @override
  Widget build(BuildContext context) {

    var local=AppLocalizations.of(context);
    String thumbnail1=YoutubePlayer.getThumbnail(videoId:YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=A4Zs0NNF9Dc&t=2s') ?? '');
    String thumbnail2=YoutubePlayer.getThumbnail(videoId:YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=gedoSfZvBgE') ?? '');
    String thumbnail3=YoutubePlayer.getThumbnail(videoId:YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=wUEl8KrMz14&t=38s') ?? '');
    String thumbnail4=YoutubePlayer.getThumbnail(videoId:YoutubePlayer.convertUrlToId('https://www.youtube.com/shorts/C-54iHtctUQ') ?? '');

    const Color appBarText=Colors.black;
    const Color fontColor=appBarText;
    const Color cardBackGround=Colors.white;

    // Previous Color(0xffebe8f0),
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff5f259f),
        appBar: AppBar(toolbarHeight: 80,elevation: 0,flexibleSpace: Container(
          margin: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(child: StreamBuilder(builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if(!snapshot.hasData){
                  return Text(textAlign: TextAlign.start,local.studentName,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w800),);
                }
                if(snapshot.data!.snapshot.exists){
                  user.User u=user.User.fromJson(snapshot.data!.snapshot.value as Map);
                  name=u.name;
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile(user : u)));
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xff5f259f),                          ),
                          child: u.imageUrl ==null ? ClipRRect(borderRadius: BorderRadius.circular(40),child: Image.asset("assets/sleep.png",height: 40,width: 40,)) : ClipRRect(borderRadius: BorderRadius.circular(40),child: Image.network(u.imageUrl!,height: 40,width: 40,fit: BoxFit.cover,)),
                        ),
                      ),
                      Text(textAlign: TextAlign.start,u.name,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
                    ],
                  );
                }else{
                  Future.delayed(Duration.zero, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()));
                  });
                }
                return Text(textAlign: TextAlign.start,local.studentName,style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w800),);
              },stream: FirebaseDatabase.instance.ref('users').child(FirebaseAuth.instance.currentUser!.uid).onValue,)),
              StreamBuilder(builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if(!snapshot.hasData) return Container(height: 20,width: 20,margin:EdgeInsets.all(8),child: CircularProgressIndicator(color: Colors.white));
                return FutureBuilder(builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if(!snapshot.hasData) return Container(height: 20,width: 20,margin:EdgeInsets.all(8),child: CircularProgressIndicator(color: Colors.white));
                  return GestureDetector(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> Notifications(notifications: notifications))),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: const Color(0xff5f259f)
                      ),
                      child: Icon(snapshot.data == true ?Icons.notifications : Icons.notifications_active,color: Colors.white,),
                    ),
                  );
                },future: getData(),);
              },stream: FirebaseDatabase.instance.ref('notifications').onValue,),
            ],
          ),),),
        body: Card(
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
          child: Column(
            children: [
              if(visible)LinearProgressIndicator(color: Color(0xff5f259f),),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top:16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          CarouselSlider(items: List<int>.generate(21, (i) => i + 1).map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Card(
                                  color: Color(0xffe5e5ff),
                                  margin: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 16),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(width: double.infinity,child: Text(textAlign: TextAlign.start,local.quote,style: TextStyle(color: fontColor,fontSize: 24,fontWeight: FontWeight.w800),)),
                                        SizedBox(height: 16,),
                                        Text(textAlign: TextAlign.justify,local.localeName=='hi' ? hindiQuotes [i-1] : quotes[i-1],style: TextStyle(color: appBarText,fontSize: 16,fontWeight: FontWeight.w400),),
                                      ],
                                    ),
                                  ),
                                );

                              },
                            );
                          }).toList(), options: CarouselOptions(viewportFraction: 1,autoPlay: true,autoPlayInterval: Duration(seconds: 4),autoPlayAnimationDuration: Duration(milliseconds: 300)),),
                          Container(width: double.infinity,margin: const EdgeInsets.only(top: 16,left: 16,bottom: 8),child: Text(textAlign: TextAlign.start,local.suggestedVideos,style: TextStyle(color: fontColor,fontSize: 18,fontWeight: FontWeight.w800),)),
                          Container(
                            height: 235,
                            margin: EdgeInsets.only(left: 16,right: 16),
                            child: ListView.builder(scrollDirection: Axis.horizontal,itemBuilder: (BuildContext context, int i){
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 16,),
                                          Stack(
                                            alignment: AlignmentDirectional.center,
                                            children: [
                                              ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.network(i==0 ? thumbnail1 : i==1 ? thumbnail2 : i==2 ?thumbnail3 : thumbnail4,height: 175)),
                                              GestureDetector(onTap:() async {
                                                if(i==0){
                                                  if (!await launchUrl(Uri.parse("https://www.youtube.com/watch?v=A4Zs0NNF9Dc&t=2s"),mode: LaunchMode.externalApplication)) {
                                                    throw Exception('Could not launch https://www.youtube.com/watch?v=A4Zs0NNF9Dc&t=2s');
                                                  }
                                                }
                                                if(i==1){
                                                  if (!await launchUrl(Uri.parse("https://www.youtube.com/watch?v=gedoSfZvBgE"),mode: LaunchMode.externalApplication)) {
                                                    throw Exception('Could not launch https://www.youtube.com/watch?v=gedoSfZvBgE');
                                                  }
                                                }
                                                if(i==2){
                                                  if (!await launchUrl(Uri.parse("https://www.youtube.com/watch?v=wUEl8KrMz14&t=38s"),mode: LaunchMode.externalApplication)) {
                                                    throw Exception('Could not launch https://www.youtube.com/watch?v=wUEl8KrMz14&t=38s');
                                                  }
                                                }
                                                if(i==3){
                                                  if (!await launchUrl(Uri.parse("https://www.youtube.com/shorts/C-54iHtctUQ"),mode: LaunchMode.externalApplication)) {
                                                    throw Exception('Could not launch https://www.youtube.com/shorts/C-54iHtctUQ');
                                                  }
                                                }

                                      },child: Icon(Icons.play_arrow,size: 70,color: Colors.white,)),
                                            ],
                                          ),
                                          SizedBox(height: 24,),
                                          Center(child: Text(i==1 ? local.whyImportant : i==2 ? local.benefitsOfSleep : i==3 ? local.whySittingIsBad : local.whyLazy,style: TextStyle(color: appBarText,fontSize: 14,fontWeight: FontWeight.bold),))
                                        ],
                                      ),
                                    );
                                  },itemCount: 4,
                                ),
                          ),
                          SizedBox(height: 16,),
                          Container(margin: const EdgeInsets.only(top: 16,left: 16,bottom: 8),child: Text('Surveys',style: TextStyle(color: appBarText,fontSize: 18,fontWeight: FontWeight.bold),)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                child: FutureBuilder(builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                  if(!snapshot.hasData) return Center(child: CircularProgressIndicator(color: Color(0xff5f259f),));
                                  if(snapshot.data!.snapshot.exists) {
                                    user.User u = user.User.fromJson(snapshot.data!.snapshot.value as Map);

                                    DateTime time = new DateFormat("dd-MMM-yyyy").parse(u.timeStamp);
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                visible = true;
                                                FirebaseDatabase.instance.ref('surveys')
                                                    .orderByChild('uid').equalTo(
                                                    FirebaseAuth.instance.currentUser!.uid)
                                                    .once()
                                                    .then((value) {
                                                  bool found = false;
                                                  model.Survey? selected;
                                                  for (DataSnapshot snap in value.snapshot
                                                      .children) {
                                                    model.Survey survey = model.Survey
                                                        .fromJson(snap.value as Map);
                                                    print(survey.toString());
                                                    if (survey.week == 'Week1') {
                                                      found = true;
                                                      selected = survey;
                                                    }
                                                  }
                                                  setState(() {
                                                    visible = false;
                                                  });
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) =>
                                                      found
                                                          ? ReportScreen(
                                                        user: selected!.uid,
                                                        answerList: selected!.answers,
                                                        name: name,)
                                                          : Survey(name: name,
                                                        title: '${local.week} 1',
                                                        week: 'Week1',)));
                                                });
                                              });
                                            },
                                            child: Container(
                                              height: 60,
                                              width: 140,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(8),
                                              margin: EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                  color: Color(0xff5f259f),
                                                  borderRadius: BorderRadius.circular(10)),
                                              child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                                                // Icon(Icons.watch,color: Color(0xff5f259f),),
                                                // SizedBox(height: 10,),
                                                Text(textAlign: TextAlign.start,
                                                  "${local.week} 1",
                                                  style: TextStyle(color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w800),),
                                                ])
                                            ),
                                          ),
                                          if(time.add(Duration(days: 7)).isBefore(DateTime.now()))GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                visible = true;
                                                FirebaseDatabase.instance.ref('surveys')
                                                    .orderByChild('uid').equalTo(
                                                    FirebaseAuth.instance.currentUser!.uid)
                                                    .once()
                                                    .then((value) {
                                                  bool found = false;
                                                  model.Survey? selected;
                                                  for (DataSnapshot snap in value.snapshot
                                                      .children) {
                                                    model.Survey survey = model.Survey
                                                        .fromJson(snap.value as Map);
                                                    print(survey.toString());
                                                    if (survey.week == 'Week2') {
                                                      found = true;
                                                      selected = survey;
                                                    }
                                                  }
                                                  setState(() {
                                                    visible = false;
                                                  });
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) =>
                                                      found
                                                          ? ReportScreen(
                                                        user: selected!.uid,
                                                        answerList: selected!.answers,
                                                        name: name,)
                                                          : Survey(name: name,
                                                        title: '${local.week} 2',
                                                        week: 'Week2',)));
                                                });
                                              });
                                            },
                                            child: Container(
                                                height: 60,
                                                width: 140,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(8),
                                                margin: EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                    color: Color(0xff5f259f),
                                                    borderRadius: BorderRadius.circular(10)),
                                                child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                                                  // Icon(Icons.watch,color: Color(0xff5f259f),),
                                                  // SizedBox(height: 10,),
                                                  Text(textAlign: TextAlign.start,
                                                    "${local.week} 2",
                                                    style: TextStyle(color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w800),),
                                                ])
                                            ),
                                          ),
                                          if(time.add(Duration(days: 14)).isBefore(DateTime.now()))GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                visible = true;
                                                FirebaseDatabase.instance.ref('surveys')
                                                    .orderByChild('uid').equalTo(
                                                    FirebaseAuth.instance.currentUser!.uid)
                                                    .once()
                                                    .then((value) {
                                                  bool found = false;
                                                  model.Survey? selected;
                                                  for (DataSnapshot snap in value.snapshot
                                                      .children) {
                                                    model.Survey survey = model.Survey
                                                        .fromJson(snap.value as Map);
                                                    print(survey.toString());
                                                    if (survey.week == 'Week3') {
                                                      found = true;
                                                      selected = survey;
                                                    }
                                                  }
                                                  setState(() {
                                                    visible = false;
                                                  });
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) =>
                                                      found
                                                          ? ReportScreen(
                                                        user: selected!.uid,
                                                        answerList: selected!.answers,
                                                        name: name,)
                                                          : Survey(name: name,
                                                        title: '${local.week} 3',
                                                        week: 'Week3',)));
                                                });
                                              });
                                            },
                                            child: Container(
                                                height: 60,
                                                width: 140,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(8),
                                                margin: EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                    color: Color(0xff5f259f),
                                                    borderRadius: BorderRadius.circular(10)),
                                                child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                                                  // Icon(Icons.watch,color: Color(0xff5f259f),),
                                                  // SizedBox(height: 10,),
                                                  Text(textAlign: TextAlign.start,
                                                    "${local.week} 3",
                                                    style: TextStyle(color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w800),),
                                                ])
                                            ),
                                          ),
                                          if(time.add(Duration(days: 21)).isBefore(DateTime.now()))GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                visible = true;
                                                FirebaseDatabase.instance.ref('surveys')
                                                    .orderByChild('uid').equalTo(
                                                    FirebaseAuth.instance.currentUser!.uid)
                                                    .once()
                                                    .then((value) {
                                                  bool found = false;
                                                  model.Survey? selected;
                                                  for (DataSnapshot snap in value.snapshot
                                                      .children) {
                                                    model.Survey survey = model.Survey
                                                        .fromJson(snap.value as Map);
                                                    print(survey.toString());
                                                    if (survey.week == 'Week4') {
                                                      found = true;
                                                      selected = survey;
                                                    }
                                                  }
                                                  setState(() {
                                                    visible = false;
                                                  });
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) =>
                                                      found
                                                          ? ReportScreen(
                                                        user: selected!.uid,
                                                        answerList: selected!.answers,
                                                        name: name,)
                                                          : Survey(name: name,
                                                        title: '${local.week} 4',
                                                        week: 'Week4',)));
                                                });
                                              });
                                            },
                                            child: Container(
                                                height: 60,
                                                width: 140,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(8),
                                                margin: EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                    color: Color(0xff5f259f),
                                                    borderRadius: BorderRadius.circular(10)),
                                                child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                                                  // Icon(Icons.watch,color: Color(0xff5f259f),),
                                                  // SizedBox(height: 10,),
                                                  Text(textAlign: TextAlign.start,
                                                    "${local.week} 4",
                                                    style: TextStyle(color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w800),),
                                                ])
                                            ),
                                          ),
                                          if(time.add(Duration(days: 28)).isBefore(DateTime.now()))GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                visible = true;
                                                FirebaseDatabase.instance.ref('surveys')
                                                    .orderByChild('uid').equalTo(
                                                    FirebaseAuth.instance.currentUser!.uid)
                                                    .once()
                                                    .then((value) {
                                                  bool found = false;
                                                  model.Survey? selected;
                                                  for (DataSnapshot snap in value.snapshot
                                                      .children) {
                                                    model.Survey survey = model.Survey
                                                        .fromJson(snap.value as Map);
                                                    print(survey.toString());
                                                    if (survey.week == 'Week5') {
                                                      found = true;
                                                      selected = survey;
                                                    }
                                                  }
                                                  setState(() {
                                                    visible = false;
                                                  });
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) =>
                                                      found
                                                          ? ReportScreen(
                                                        user: selected!.uid,
                                                        answerList: selected!.answers,
                                                        name: name,)
                                                          : Survey(name: name,
                                                        title: '${local.week} 5',
                                                        week: 'Week5',)));
                                                });
                                              });
                                            },
                                            child: Container(
                                                height: 60,
                                                width: 140,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(8),
                                                margin: EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                    color: Color(0xff5f259f),
                                                    borderRadius: BorderRadius.circular(10)),
                                                child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                                                  // Icon(Icons.watch,color: Color(0xff5f259f),),
                                                  // SizedBox(height: 10,),
                                                  Text(textAlign: TextAlign.start,
                                                    "${local.week} 5",
                                                    style: TextStyle(color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w800),),
                                                ])
                                            ),
                                          ),
                                          if(time.add(Duration(days: 35)).isBefore(DateTime.now()))GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                visible = true;
                                                FirebaseDatabase.instance.ref('surveys')
                                                    .orderByChild('uid').equalTo(
                                                    FirebaseAuth.instance.currentUser!.uid)
                                                    .once()
                                                    .then((value) {
                                                  bool found = false;
                                                  model.Survey? selected;
                                                  for (DataSnapshot snap in value.snapshot
                                                      .children) {
                                                    model.Survey survey = model.Survey
                                                        .fromJson(snap.value as Map);
                                                    print(survey.toString());
                                                    if (survey.week == 'Week6') {
                                                      found = true;
                                                      selected = survey;
                                                    }
                                                  }
                                                  setState(() {
                                                    visible = false;
                                                  });
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) =>
                                                      found
                                                          ? ReportScreen(
                                                        user: selected!.uid,
                                                        answerList: selected!.answers,
                                                        name: name,)
                                                          : Survey(name: name,
                                                        title: '${local.week} 6',
                                                        week: 'Week6',)));
                                                });
                                              });
                                            },
                                            child: Container(
                                                height: 60,
                                                width: 140,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(8),
                                                margin: EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                    color: Color(0xff5f259f),
                                                    borderRadius: BorderRadius.circular(10)),
                                                child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                                                  // Icon(Icons.watch,color: Color(0xff5f259f),),
                                                  // SizedBox(height: 10,),
                                                  Text(textAlign: TextAlign.start,
                                                    "${local.week} 6",
                                                    style: TextStyle(color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w800),),
                                                ])
                                            ),
                                          ),
                                          if(time.add(Duration(days: 42)).isBefore(DateTime.now()))GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                visible = true;
                                                FirebaseDatabase.instance.ref('surveys')
                                                    .orderByChild('uid').equalTo(
                                                    FirebaseAuth.instance.currentUser!.uid)
                                                    .once()
                                                    .then((value) {
                                                  bool found = false;
                                                  model.Survey? selected;
                                                  for (DataSnapshot snap in value.snapshot
                                                      .children) {
                                                    model.Survey survey = model.Survey
                                                        .fromJson(snap.value as Map);
                                                    print(survey.toString());
                                                    if (survey.week == 'Week7') {
                                                      found = true;
                                                      selected = survey;
                                                    }
                                                  }
                                                  setState(() {
                                                    visible = false;
                                                  });
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) =>
                                                      found
                                                          ? ReportScreen(
                                                        user: selected!.uid,
                                                        answerList: selected!.answers,
                                                        name: name,)
                                                          : Survey(name: name,
                                                        title: '${local.week} 7',
                                                        week: 'Week7',)));
                                                });
                                              });
                                            },
                                            child: Container(
                                                height: 60,
                                                width: 140,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(8),
                                                margin: EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                    color: Color(0xff5f259f),
                                                    borderRadius: BorderRadius.circular(10)),
                                                child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                                                  // Icon(Icons.watch,color: Color(0xff5f259f),),
                                                  // SizedBox(height: 10,),
                                                  Text(textAlign: TextAlign.start,
                                                    "${local.week} 7",
                                                    style: TextStyle(color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w800),),
                                                ])
                                            ),
                                          ),
                                          if(time.add(Duration(days: 49)).isBefore(DateTime.now()))GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                visible = true;
                                                FirebaseDatabase.instance.ref('surveys')
                                                    .orderByChild('uid').equalTo(
                                                    FirebaseAuth.instance.currentUser!.uid)
                                                    .once()
                                                    .then((value) {
                                                  bool found = false;
                                                  model.Survey? selected;
                                                  for (DataSnapshot snap in value.snapshot
                                                      .children) {
                                                    model.Survey survey = model.Survey
                                                        .fromJson(snap.value as Map);
                                                    print(survey.toString());
                                                    if (survey.week == 'Week8') {
                                                      found = true;
                                                      selected = survey;
                                                    }
                                                  }
                                                  setState(() {
                                                    visible = false;
                                                  });
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) =>
                                                      found
                                                          ? ReportScreen(
                                                        user: selected!.uid,
                                                        answerList: selected!.answers,
                                                        name: name,)
                                                          : Survey(name: name,
                                                        title: '${local.week} 1',
                                                        week: 'Week8',)));
                                                });
                                              });
                                            },
                                            child: Container(
                                                height: 60,
                                                width: 140,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(8),
                                                margin: EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                    color: Color(0xff5f259f),
                                                    borderRadius: BorderRadius.circular(10)),
                                                child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                                                  // Icon(Icons.watch,color: Color(0xff5f259f),),
                                                  // SizedBox(height: 10,),
                                                  Text(textAlign: TextAlign.start,
                                                    "${local.week} 8",
                                                    style: TextStyle(color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w800),),
                                                ])
                                            ),
                                          ),
                                          if(time.add(Duration(days: 56)).isBefore(DateTime.now()))GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                visible = true;
                                                FirebaseDatabase.instance.ref('surveys')
                                                    .orderByChild('uid').equalTo(
                                                    FirebaseAuth.instance.currentUser!.uid)
                                                    .once()
                                                    .then((value) {
                                                  bool found = false;
                                                  model.Survey? selected;
                                                  for (DataSnapshot snap in value.snapshot
                                                      .children) {
                                                    model.Survey survey = model.Survey
                                                        .fromJson(snap.value as Map);
                                                    print(survey.toString());
                                                    if (survey.week == 'Week9') {
                                                      found = true;
                                                      selected = survey;
                                                    }
                                                  }
                                                  setState(() {
                                                    visible = false;
                                                  });
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) =>
                                                      found
                                                          ? ReportScreen(
                                                        user: selected!.uid,
                                                        answerList: selected!.answers,
                                                        name: name,)
                                                          : Survey(name: name,
                                                        title: '${local.week} 9',
                                                        week: 'Week9',)));
                                                });
                                              });
                                            },
                                            child: Container(
                                                height: 60,
                                                width: 140,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(8),
                                                margin: EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                    color: Color(0xff5f259f),
                                                    borderRadius: BorderRadius.circular(10)),
                                                child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                                                  // Icon(Icons.watch,color: Color(0xff5f259f),),
                                                  // SizedBox(height: 10,),
                                                  Text(textAlign: TextAlign.start,
                                                    "${local.week} 9",
                                                    style: TextStyle(color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w800),),
                                                ])
                                            ),
                                          ),
                                          if(time.add(Duration(days: 63)).isBefore(DateTime.now()))GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                visible = true;
                                                FirebaseDatabase.instance.ref('surveys')
                                                    .orderByChild('uid').equalTo(
                                                    FirebaseAuth.instance.currentUser!.uid)
                                                    .once()
                                                    .then((value) {
                                                  bool found = false;
                                                  model.Survey? selected;
                                                  for (DataSnapshot snap in value.snapshot
                                                      .children) {
                                                    model.Survey survey = model.Survey
                                                        .fromJson(snap.value as Map);
                                                    print(survey.toString());
                                                    if (survey.week == 'Week10') {
                                                      found = true;
                                                      selected = survey;
                                                    }
                                                  }
                                                  setState(() {
                                                    visible = false;
                                                  });
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) =>
                                                      found
                                                          ? ReportScreen(
                                                        user: selected!.uid,
                                                        answerList: selected!.answers,
                                                        name: name,)
                                                          : Survey(name: name,
                                                        title: '${local.week} 10',
                                                        week: 'Week10',)));
                                                });
                                              });
                                            },
                                            child: Container(
                                                height: 60,
                                                width: 140,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(8),
                                                margin: EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                    color: Color(0xff5f259f),
                                                    borderRadius: BorderRadius.circular(10)),
                                                child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                                                  // Icon(Icons.watch,color: Color(0xff5f259f),),
                                                  // SizedBox(height: 10,),
                                                  Text(textAlign: TextAlign.start,
                                                    "${local.week} 10",
                                                    style: TextStyle(color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w800),),
                                                ])
                                            ),
                                          ),
                                          if(time.add(Duration(days: 70)).isBefore(DateTime.now()))GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                visible = true;
                                                FirebaseDatabase.instance.ref('surveys')
                                                    .orderByChild('uid').equalTo(
                                                    FirebaseAuth.instance.currentUser!.uid)
                                                    .once()
                                                    .then((value) {
                                                  bool found = false;
                                                  model.Survey? selected;
                                                  for (DataSnapshot snap in value.snapshot
                                                      .children) {
                                                    model.Survey survey = model.Survey
                                                        .fromJson(snap.value as Map);
                                                    print(survey.toString());
                                                    if (survey.week == 'Week11') {
                                                      found = true;
                                                      selected = survey;
                                                    }
                                                  }
                                                  setState(() {
                                                    visible = false;
                                                  });
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) =>
                                                      found
                                                          ? ReportScreen(
                                                        user: selected!.uid,
                                                        answerList: selected!.answers,
                                                        name: name,)
                                                          : Survey(name: name,
                                                        title: '${local.week} 11',
                                                        week: 'Week11',)));
                                                });
                                              });
                                            },
                                            child: Container(
                                                height: 60,
                                                width: 140,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(8),
                                                margin: EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                    color: Color(0xff5f259f),
                                                    borderRadius: BorderRadius.circular(10)),
                                                child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                                                  // Icon(Icons.watch,color: Color(0xff5f259f),),
                                                  // SizedBox(height: 10,),
                                                  Text(textAlign: TextAlign.start,
                                                    "${local.week} 11",
                                                    style: TextStyle(color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w800),),
                                                ])
                                            ),
                                          ),
                                          if(time.add(Duration(days: 77)).isBefore(DateTime.now()))GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                visible = true;
                                                FirebaseDatabase.instance.ref('surveys')
                                                    .orderByChild('uid').equalTo(
                                                    FirebaseAuth.instance.currentUser!.uid)
                                                    .once()
                                                    .then((value) {
                                                  bool found = false;
                                                  model.Survey? selected;
                                                  for (DataSnapshot snap in value.snapshot
                                                      .children) {
                                                    model.Survey survey = model.Survey
                                                        .fromJson(snap.value as Map);
                                                    print(survey.toString());
                                                    if (survey.week == 'Week12') {
                                                      found = true;
                                                      selected = survey;
                                                    }
                                                  }
                                                  setState(() {
                                                    visible = false;
                                                  });
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) =>
                                                      found
                                                          ? ReportScreen(
                                                        user: selected!.uid,
                                                        answerList: selected!.answers,
                                                        name: name,)
                                                          : Survey(name: name,
                                                        title: '${local.week} 1',
                                                        week: 'Week12',)));
                                                });
                                              });
                                            },
                                            child: Container(
                                                height: 60,
                                                width: 140,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(8),
                                                margin: EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                    color: Color(0xff5f259f),
                                                    borderRadius: BorderRadius.circular(10)),
                                                child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                                                  // Icon(Icons.watch,color: Color(0xff5f259f),),
                                                  // SizedBox(height: 10,),
                                                  Text(textAlign: TextAlign.start,
                                                    "${local.week} 12",
                                                    style: TextStyle(color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w800),),
                                                ])
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return SizedBox();
                                },future: FirebaseDatabase.instance.ref('users').child(FirebaseAuth.instance.currentUser!.uid).once(),),
                              ),
                            ],
                          ),
               Container(margin: const EdgeInsets.only(top: 24,left: 16,bottom: 8),child: Text(local.contactAndRecommendation,style: TextStyle(color: appBarText,fontSize: 18,fontWeight: FontWeight.bold),)),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutUs()));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    child: Container(decoration: BoxDecoration(color: Color(0xff5f259f),borderRadius: BorderRadius.circular(60)),child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Icon(Icons.person,color: Colors.white,),
                                    )),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(textAlign: TextAlign.center,local.aboutUs,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w800),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ContactUs()));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    child: Container(decoration: BoxDecoration(color: Color(0xff5f259f),borderRadius: BorderRadius.circular(60)),child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Icon(Icons.call,color: Colors.white,),
                                    )),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(textAlign: TextAlign.center,local.contactUs,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w800),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Recommendations()));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    child: Container(decoration: BoxDecoration(color: Color(0xff5f259f),borderRadius: BorderRadius.circular(60)),child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Icon(Icons.shield_moon,color: Colors.white,),
                                    )),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(textAlign: TextAlign.center,local.sleepRecommendations,style: TextStyle(color: Colors.black,fontSize: 8,fontWeight: FontWeight.w800),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ])
                        ]
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<bool> getData() async {
    bool read=true;
    await FirebaseDatabase.instance.ref('notifications').once().then((value) async {
      notifications.clear();
      var sharep=await SharedPreferences.getInstance();
      for(DataSnapshot snap in value.snapshot.children){
        NotificationModel model=NotificationModel.fromJson(snap.value as Map);
        notifications.add(model.id);
        if(sharep.getBool(model.id)==null){
          print(sharep.getBool(model.id));
          read=false;
        }
      }
    });
    return read;
  }
}
class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, required this.hint}) : super(key: key);
  final String hint;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(margin: EdgeInsets.all(16),width: double.infinity,child: Text(textAlign: TextAlign.left,hint,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)),
        Container(margin: EdgeInsets.only(left: 16,right: 16),padding:EdgeInsets.only(left: 16,right: 16),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(16)),height: 60,width: double.infinity,child: Center(child: TextField(decoration: InputDecoration(hintText: "Enter $hint",border: InputBorder.none)))),
      ],
    );
  }
}

