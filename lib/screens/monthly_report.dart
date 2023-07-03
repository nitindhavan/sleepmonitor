import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sleepmonitor/models/User.dart';
import 'package:sleepmonitor/models/Survey.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class MonthlyReport extends StatefulWidget {
  const MonthlyReport({Key? key,required this.user}) : super(key: key);

  final String user;

  @override
  State<MonthlyReport> createState() => _MonthlyReportState();
}

class _MonthlyReportState extends State<MonthlyReport> {
  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Color(0xff5f259f),
      body: Card(
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          child: FutureBuilder(builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator());
            }
            if(!snapshot.data!.snapshot.exists){
              return const Center(child: Text("No Survey Submitted yet"),);
            }else{
              List<Survey?> surveyList=[];
              for(int i=0; i<12;i++){
                surveyList.add(null);
              }
              List<Widget> weekList=[];
              DateTime currentDate=DateTime.now();
              for(DataSnapshot snap in snapshot.data!.snapshot.children) {
                Survey survey = Survey.fromJson(snap.value as Map);
                int index=int.parse(survey.week.replaceAll("Week", ""));
                surveyList[index-1]=survey;
                surveyList.add(survey);
              }
              for(int i=1 ; i<=12;i++){
                weekList.add(Expanded(child: Text('${local.week} $i',textAlign: TextAlign.center,)));
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text(local.sleepDuration,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Card(
                        color: Color(0xffe5e5ff),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if(surveyList[0]!=null)Bar(height: durationScore(surveyList[0]!.answers)*2,label: Text('${local.week} 1'),topLabel: Text('${durationScore(surveyList[0]!.answers)}'),),
                              if(surveyList[1]!=null)Bar(height: durationScore(surveyList[1]!.answers)*2,label: Text('${local.week} 2'),topLabel: Text('${durationScore(surveyList[1]!.answers)}'),),
                              if(surveyList[2]!=null)Bar(height: durationScore(surveyList[2]!.answers)*2,label: Text('${local.week} 3'),topLabel: Text('${durationScore(surveyList[2]!.answers)}'),),
                              if(surveyList[3]!=null)Bar(height: durationScore(surveyList[3]!.answers)*2,label: Text('${local.week} 4'),topLabel: Text('${durationScore(surveyList[3]!.answers)}'),),
                              if(surveyList[4]!=null)Bar(height: durationScore(surveyList[4]!.answers)*2,label: Text('${local.week} 5'),topLabel: Text('${durationScore(surveyList[4]!.answers)}'),),
                              if(surveyList[5]!=null)Bar(height: durationScore(surveyList[5]!.answers)*2,label: Text('${local.week} 6'),topLabel: Text('${durationScore(surveyList[5]!.answers)}'),),
                              if(surveyList[6]!=null)Bar(height: durationScore(surveyList[6]!.answers)*2,label: Text('${local.week} 7'),topLabel: Text('${durationScore(surveyList[6]!.answers)}'),),
                              if(surveyList[7]!=null)Bar(height: durationScore(surveyList[7]!.answers)*2,label: Text('${local.week} 8'),topLabel: Text('${durationScore(surveyList[7]!.answers)}'),),
                              if(surveyList[8]!=null)Bar(height: durationScore(surveyList[8]!.answers)*2,label: Text('${local.week} 9'),topLabel: Text('${durationScore(surveyList[8]!.answers)}'),),
                              if(surveyList[9]!=null)Bar(height: durationScore(surveyList[9]!.answers)*2,label: Text('${local.week} 10'),topLabel: Text('${durationScore(surveyList[9]!.answers)}'),),
                              if(surveyList[10]!=null)Bar(height: durationScore(surveyList[10]!.answers)*2,label: Text('${local.week} 11'),topLabel: Text('${durationScore(surveyList[10]!.answers)}'),),
                              if(surveyList[11]!=null)Bar(height: durationScore(surveyList[11]!.answers)*2,label: Text('${local.week} 12'),topLabel: Text('${durationScore(surveyList[11]!.answers)}'),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32,),
                    Text(local.nap,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Card(
                        color: Color(0xffe5e5ff),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: 200,),
                              if(surveyList[0]!=null)Bar(height: (surveyList[0]!.answers[4])*50,label: Text('${local.week} 1'),topLabel: Text(getNapData(surveyList[0]!.answers,4),)),
                              if(surveyList[1]!=null)Bar(height: (surveyList[1]!.answers[4])*50,label: Text('${local.week} 2'),topLabel: Text(getNapData(surveyList[1]!.answers,4),)),
                              if(surveyList[2]!=null)Bar(height: (surveyList[2]!.answers[4])*50,label: Text('${local.week} 3'),topLabel: Text(getNapData(surveyList[2]!.answers,4),)),
                              if(surveyList[3]!=null)Bar(height: (surveyList[3]!.answers[4])*50,label: Text('${local.week} 4'),topLabel: Text(getNapData(surveyList[3]!.answers,4),)),
                              if(surveyList[4]!=null)Bar(height: (surveyList[4]!.answers[4])*50,label: Text('${local.week} 5'),topLabel: Text(getNapData(surveyList[4]!.answers,4),)),
                              if(surveyList[5]!=null)Bar(height: (surveyList[5]!.answers[4])*50,label: Text('${local.week} 6'),topLabel: Text(getNapData(surveyList[5]!.answers,4),)),
                              if(surveyList[6]!=null)Bar(height: (surveyList[6]!.answers[4])*50,label: Text('${local.week} 7'),topLabel: Text(getNapData(surveyList[6]!.answers,4),)),
                              if(surveyList[7]!=null)Bar(height: (surveyList[7]!.answers[4])*50,label: Text('${local.week} 8'),topLabel: Text(getNapData(surveyList[7]!.answers,4),)),
                              if(surveyList[8]!=null)Bar(height: (surveyList[8]!.answers[4])*50,label: Text('${local.week} 9'),topLabel: Text(getNapData(surveyList[8]!.answers,4),)),
                              if(surveyList[9]!=null)Bar(height: (surveyList[9]!.answers[4])*50,label: Text('${local.week} 10'),topLabel: Text(getNapData(surveyList[9]!.answers,4),)),
                              if(surveyList[10]!=null)Bar(height: (surveyList[10]!.answers[4])*50,label: Text('${local.week} 11'),topLabel: Text(getNapData(surveyList[10]!.answers,4),)),
                              if(surveyList[11]!=null)Bar(height: (surveyList[11]!.answers[4])*50,label: Text('${local.week} 12'),topLabel: Text(getNapData(surveyList[11]!.answers,4),)),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 32,),
                    Text(local.physical,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Card(
                        color: Color(0xffe5e5ff),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: 200,),
                              if(surveyList[0]!=null)Bar(height: (surveyList[0]!.answers[5])*50,label: Text('${local.week} 1'),topLabel: Text(getNapData(surveyList[0]!.answers,5),)),
                              if(surveyList[1]!=null)Bar(height: (surveyList[1]!.answers[5])*50,label: Text('${local.week} 2'),topLabel: Text(getNapData(surveyList[1]!.answers,5),)),
                              if(surveyList[2]!=null)Bar(height: (surveyList[2]!.answers[5])*50,label: Text('${local.week} 3'),topLabel: Text(getNapData(surveyList[2]!.answers,5),)),
                              if(surveyList[3]!=null)Bar(height: (surveyList[3]!.answers[5])*50,label: Text('${local.week} 4'),topLabel: Text(getNapData(surveyList[3]!.answers,5),)),
                              if(surveyList[4]!=null)Bar(height: (surveyList[4]!.answers[5])*50,label: Text('${local.week} 5'),topLabel: Text(getNapData(surveyList[4]!.answers,5),)),
                              if(surveyList[5]!=null)Bar(height: (surveyList[5]!.answers[5])*50,label: Text('${local.week} 6'),topLabel: Text(getNapData(surveyList[5]!.answers,5),)),
                              if(surveyList[6]!=null)Bar(height: (surveyList[6]!.answers[5])*50,label: Text('${local.week} 7'),topLabel: Text(getNapData(surveyList[6]!.answers,5),)),
                              if(surveyList[7]!=null)Bar(height: (surveyList[7]!.answers[5])*50,label: Text('${local.week} 8'),topLabel: Text(getNapData(surveyList[7]!.answers,5),)),
                              if(surveyList[8]!=null)Bar(height: (surveyList[8]!.answers[5])*50,label: Text('${local.week} 9'),topLabel: Text(getNapData(surveyList[8]!.answers,5),)),
                              if(surveyList[9]!=null)Bar(height: (surveyList[9]!.answers[5])*50,label: Text('${local.week} 10'),topLabel: Text(getNapData(surveyList[9]!.answers,5),)),
                              if(surveyList[10]!=null)Bar(height: (surveyList[10]!.answers[5])*50,label: Text('${local.week} 11'),topLabel: Text(getNapData(surveyList[10]!.answers,5),)),
                              if(surveyList[11]!=null)Bar(height: (surveyList[11]!.answers[5])*50,label: Text('${local.week} 12'),topLabel: Text(getNapData(surveyList[11]!.answers,5),)),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 32,),
                    Text(local.junkFood,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Card(
                        color: Color(0xffe5e5ff),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: 200,),
                              if(surveyList[0]!=null)Bar(height: (surveyList[0]!.answers[6])*50,label: Text('${local.week} 1'),topLabel: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/samosa.png'),)),
                                  SizedBox(height: 8,),
                                  Text(getNapData(surveyList[0]!.answers,6),),
                                ],
                              )),
                              if(surveyList[1]!=null)Bar(height: (surveyList[1]!.answers[6])*50,label: Text('${local.week} 2'),topLabel: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/pizza.png'),)), SizedBox(height: 8,),
                                  Text(getNapData(surveyList[1]!.answers,6),),
                                ],
                              )),
                              if(surveyList[2]!=null)Bar(height: (surveyList[2]!.answers[6])*50,label: Text('${local.week} 3'),topLabel: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/noodles.png'),)),
                                  SizedBox(height: 8,),
                                  Text(getNapData(surveyList[2]!.answers,6),),
                                ],
                              )),
                              if(surveyList[3]!=null)Bar(height: (surveyList[3]!.answers[6])*50,label: Text('${local.week} 4'),topLabel: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/burger.png'),)),
                                  SizedBox(height: 8,),
                                  Text(getNapData(surveyList[3]!.answers,6),),
                                ],
                              )),
                              if(surveyList[4]!=null)Bar(height: (surveyList[4]!.answers[6])*50,label: Text('${local.week} 5'),topLabel: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/samosa.png'),)),
                                  SizedBox(height: 8,),
                                  Text(getNapData(surveyList[4]!.answers,6),),
                                ],
                              )),
                              if(surveyList[5]!=null)Bar(height: (surveyList[5]!.answers[6])*50,label: Text('${local.week} 6'),topLabel: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/samosa.png'),)),
                                  SizedBox(height: 8,),
                                  Text(getNapData(surveyList[5]!.answers,6),),
                                ],
                              )),if(surveyList[6]!=null)Bar(height: (surveyList[6]!.answers[6])*50,label: Text('${local.week} 7'),topLabel: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/samosa.png'),)),
                                  SizedBox(height: 8,),
                                  Text(getNapData(surveyList[6]!.answers,6),),
                                ],
                              )),if(surveyList[7]!=null)Bar(height: (surveyList[4]!.answers[6])*50,label: Text('${local.week} 8'),topLabel: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/samosa.png'),)),
                                  SizedBox(height: 8,),
                                  Text(getNapData(surveyList[7]!.answers,6),),
                                ],
                              )),if(surveyList[8]!=null)Bar(height: (surveyList[8]!.answers[6])*50,label: Text('${local.week} 9'),topLabel: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/samosa.png'),)),
                                  SizedBox(height: 8,),
                                  Text(getNapData(surveyList[8]!.answers,6),),
                                ],
                              )),if(surveyList[9]!=null)Bar(height: (surveyList[9]!.answers[9])*50,label: Text('${local.week} 10'),topLabel: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/samosa.png'),)),
                                  SizedBox(height: 8,),
                                  Text(getNapData(surveyList[9]!.answers,6),),
                                ],
                              )),if(surveyList[10]!=null)Bar(height: (surveyList[10]!.answers[6])*50,label: Text('${local.week} 11'),topLabel: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/samosa.png'),)),
                                  SizedBox(height: 8,),
                                  Text(getNapData(surveyList[10]!.answers,6),),
                                ],
                              )),if(surveyList[11]!=null)Bar(height: (surveyList[11]!.answers[6])*50,label: Text('${local.week} 12'),topLabel: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/samosa.png'),)),
                                  SizedBox(height: 8,),
                                  Text(getNapData(surveyList[11]!.answers,6),),
                                ],
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 32,),
                    Text(local.cafinatedBeverages,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Card(
                        color: Color(0xffe5e5ff),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: 200,),
                              if(surveyList[0]!=null)Bar(height: (surveyList[0]!.answers[7])*50,label: Text('${local.week} 1'),topLabel: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/tea.png'),)),
                                  SizedBox(height: 8,),
                                  Text(getNapData(surveyList[0]!.answers,7),),
                                ],
                              )),


                              if(surveyList[1]!=null)Bar(height: (surveyList[1]!.answers[7])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/can.png'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 2'),
                                ],
                              ),topLabel: Text(getNapData(surveyList[1]!.answers,7),)),


                              if(surveyList[2]!=null)Bar(height: (surveyList[2]!.answers[7])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/cofee.png'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 3'),
                                ],
                              ),topLabel: Text(getNapData(surveyList[2]!.answers,7),)),


                              if(surveyList[3]!=null)Bar(height: (surveyList[3]!.answers[7])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/coke.png'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 4'),
                                ],
                              ),topLabel: Text(getNapData(surveyList[3]!.answers,7),)),


                              if(surveyList[4]!=null)Bar(height: (surveyList[4]!.answers[7])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/coldrink.png'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 5'),
                                ],
                              ),topLabel: Text(getNapData(surveyList[4]!.answers,7),)),

                              if(surveyList[5]!=null)Bar(height: (surveyList[5]!.answers[7])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/coldrink.png'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 6'),
                                ],
                              ),topLabel: Text(getNapData(surveyList[5]!.answers,7),)),

                              if(surveyList[6]!=null)Bar(height: (surveyList[6]!.answers[7])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/coldrink.png'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 7'),
                                ],
                              ),topLabel: Text(getNapData(surveyList[6]!.answers,7),)),

                              if(surveyList[7]!=null)Bar(height: (surveyList[7]!.answers[7])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/coldrink.png'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 8'),
                                ],
                              ),topLabel: Text(getNapData(surveyList[7]!.answers,7),)),

                              if(surveyList[8]!=null)Bar(height: (surveyList[8]!.answers[7])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/coldrink.png'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 9'),
                                ],
                              ),topLabel: Text(getNapData(surveyList[8]!.answers,7),)),


                              if(surveyList[9]!=null)Bar(height: (surveyList[9]!.answers[7])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/coldrink.png'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 10'),
                                ],
                              ),topLabel: Text(getNapData(surveyList[9]!.answers,7),)),

                              if(surveyList[10]!=null)Bar(height: (surveyList[10]!.answers[7])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/coldrink.png'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 11'),
                                ],
                              ),topLabel: Text(getNapData(surveyList[10]!.answers,7),)),


                              if(surveyList[11]!=null)Bar(height: (surveyList[11]!.answers[7])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/coldrink.png'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 12'),
                                ],
                              ),topLabel: Text(getNapData(surveyList[11]!.answers,7),)),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 32,),
                    Text(local.mood,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Card(
                        color: Color(0xffe5e5ff),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: 200,),
                              if(surveyList[0]!=null)Bar(height: (surveyList[0]!.answers[8])*50,label: Text('${local.week} 1'),topLabel: getMoodData(surveyList[0]!.answers,8,),color: Color(0xffe5e5ff),),
                              if(surveyList[1]!=null)Bar(height: (surveyList[1]!.answers[8])*50,label: Text('${local.week} 2'),topLabel: getMoodData(surveyList[1]!.answers,8,),color: Color(0xffe5e5ff),),
                              if(surveyList[2]!=null)Bar(height: (surveyList[2]!.answers[8])*50,label: Text('${local.week} 3'),topLabel: getMoodData(surveyList[2]!.answers,8,),color: Color(0xffe5e5ff),),
                              if(surveyList[3]!=null)Bar(height: (surveyList[3]!.answers[8])*50,label: Text('${local.week} 4'),topLabel: getMoodData(surveyList[3]!.answers,8,),color: Color(0xffe5e5ff),),
                              if(surveyList[4]!=null)Bar(height: (surveyList[4]!.answers[8])*50,label: Text('${local.week} 5'),topLabel: getMoodData(surveyList[4]!.answers,8,),color: Color(0xffe5e5ff),),
                              if(surveyList[5]!=null)Bar(height: (surveyList[5]!.answers[8])*50,label: Text('${local.week} 6'),topLabel: getMoodData(surveyList[5]!.answers,8,),color: Color(0xffe5e5ff),),
                              if(surveyList[6]!=null)Bar(height: (surveyList[6]!.answers[8])*50,label: Text('${local.week} 7'),topLabel: getMoodData(surveyList[6]!.answers,8,),color: Color(0xffe5e5ff),),
                              if(surveyList[7]!=null)Bar(height: (surveyList[7]!.answers[8])*50,label: Text('${local.week} 8'),topLabel: getMoodData(surveyList[7]!.answers,8,),color: Color(0xffe5e5ff),),
                              if(surveyList[8]!=null)Bar(height: (surveyList[8]!.answers[8])*50,label: Text('${local.week} 9'),topLabel: getMoodData(surveyList[8]!.answers,8,),color: Color(0xffe5e5ff),),
                              if(surveyList[9]!=null)Bar(height: (surveyList[9]!.answers[8])*50,label: Text('${local.week} 10'),topLabel: getMoodData(surveyList[9]!.answers,8,),color: Color(0xffe5e5ff),),
                              if(surveyList[10]!=null)Bar(height: (surveyList[10]!.answers[8])*50,label: Text('${local.week} 11'),topLabel: getMoodData(surveyList[10]!.answers,8,),color: Color(0xffe5e5ff),),
                              if(surveyList[11]!=null)Bar(height: (surveyList[11]!.answers[8])*50,label: Text('${local.week} 12'),topLabel: getMoodData(surveyList[11]!.answers,8,),color: Color(0xffe5e5ff),),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 32,),
                    Text(local.screenTime,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Card(
                        color: Color(0xffe5e5ff),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: 200,),
                              if(surveyList[0]!=null)Bar(height: (surveyList[0]!.answers[9])*50,label: Text('${local.week} 1'),topLabel: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/game.jpg'),)),
                                  SizedBox(height: 8,),
                                  Text(getScreenData(surveyList[0]!.answers,9),),
                                ],
                              )),

                              if(surveyList[1]!=null)Bar(height: (surveyList[1]!.answers[9])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/laptop.png'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 2'),
                                ],
                              ),topLabel: Text(getScreenData(surveyList[1]!.answers,9),)),

                              if(surveyList[2]!=null)Bar(height: (surveyList[2]!.answers[9])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/phone.png'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 3'),
                                ],
                              ),topLabel: Text(getScreenData(surveyList[2]!.answers,9),)),

                              if(surveyList[3]!=null)Bar(height: (surveyList[3]!.answers[9])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/tv.jpg'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 4'),
                                ],
                              ),topLabel: Text(getScreenData(surveyList[3]!.answers,9),)),

                              if(surveyList[4]!=null)Bar(height: (surveyList[4]!.answers[9])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/game.jpg'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 5'),
                                ],
                              ),topLabel: Text(getScreenData(surveyList[4]!.answers,9),)),

                              if(surveyList[5]!=null)Bar(height: (surveyList[5]!.answers[9])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/game.jpg'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 6'),
                                ],
                              ),topLabel: Text(getScreenData(surveyList[6]!.answers,9),)),

                              if(surveyList[6]!=null)Bar(height: (surveyList[6]!.answers[9])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/game.jpg'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 7'),
                                ],
                              ),topLabel: Text(getScreenData(surveyList[6]!.answers,9),)),

                              if(surveyList[7]!=null)Bar(height: (surveyList[7]!.answers[9])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/game.jpg'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 8'),
                                ],
                              ),topLabel: Text(getScreenData(surveyList[7]!.answers,9),)),

                              if(surveyList[8]!=null)Bar(height: (surveyList[8]!.answers[9])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/game.jpg'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 9'),
                                ],
                              ),topLabel: Text(getScreenData(surveyList[8]!.answers,9),)),

                              if(surveyList[9]!=null)Bar(height: (surveyList[9]!.answers[9])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/game.jpg'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 10'),
                                ],
                              ),topLabel: Text(getScreenData(surveyList[9]!.answers,9),)),

                              if(surveyList[10]!=null)Bar(height: (surveyList[10]!.answers[9])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/game.jpg'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 11'),
                                ],
                              ),topLabel: Text(getScreenData(surveyList[10]!.answers,9),)),


                              if(surveyList[11]!=null)Bar(height: (surveyList[11]!.answers[9])*50,label: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('assets/game.jpg'),)),
                                  SizedBox(height: 8,),
                                  Text('${local.week} 12'),
                                ],
                              ),topLabel: Text(getScreenData(surveyList[11]!.answers,9),)),

                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              );

            }
            return Container();
          },future: FirebaseDatabase.instance.ref('surveys').orderByChild('uid').equalTo(widget.user).once(),),
        ),
      ),
    );
  }

  List<num> getData(List<Survey> surveyList) {
    List<num> list=[];
    for(int i=1;i<=12;i++){
      String text='Week$i';
      bool contains=false;
      for(Survey s in surveyList) {
        if(s.week==text) {
          list.add(durationScore(s.answers));
          contains=true;
        }
      }
      if(!contains) list.add(0);
    }

    return list;
  }

  int durationScore(List<int> answerList) {
    int totalDuration=63;
    totalDuration-= 5 * answerList[0];
    totalDuration+= 5 *answerList[1];
    totalDuration-= 2 * answerList[2];
    totalDuration+= 2 *answerList[3];
    return totalDuration;
  }

  String getNapData(List<int> answerList,int index) {
    int answer=answerList[index];
    print(answer);
    switch (answer){
      case 0:
        return '0 times';
      case 1:
        return '1-2 Times';
      case 2:
        return '3-4 times';
      case 3:
        return '5-6 times';
      default:
        return 'Everyday';
    }
  }
  String getScreenData(List<int> answerList,int index) {
    int answer=answerList[index];
    print(answer);
    switch (answer){
      case 0:
        return '0-2 Hours';
      case 1:
        return '3-5 Hours';
      case 2:
        return '6-8 Hours';
      case 3:
        return '9-12 Hours';
      default:
        return 'More than 12 Hrs';
    }
  }
  Widget getMoodData(List<int> answerList,int index) {
    int answer=answerList[index];
    print(answer);
    switch (answer){
      case 0:
        return Column(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(50),child : Container(color: Colors.white,child: Image.asset('assets/energetic.gif',height: 50,width: 50))),
          ],
        );
      case 1:
        return Column(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(50),child : Container(color: Colors.white,child: Image.asset('assets/calm.gif',height: 50,width: 50))),
          ],
        );
      case 2:
        return Column(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(50),child : Container(color: Colors.white,child: Image.asset('assets/irritated.gif',height: 50,width: 50)),),
          ],
        );
      case 3:
        return Column(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(50),child : Container(color: Colors.white,child: Image.asset('assets/anxious.gif',height: 50,width: 50))),
          ],
        );
      default:
        return Column(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(50),child : Container(color: Colors.white,child: Image.asset('assets/woried.gif',height: 50,width: 50))),
          ],
        );
    }
  }

}

class Bar extends StatelessWidget {
  const Bar(
      {Key? key, required this.height, this.label, this.topLabel, this.color})
      : super(key: key);

  final int height;

  final Color? color;
  final Widget? label;
  final Widget? topLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(topLabel != null)topLabel!,
        Container(
          height: height.toDouble(),
          width: 30,
          color: color ?? Colors.blue,
          margin: EdgeInsets.all(16),),
        if(label != null)label!,
        SizedBox(height: 16,)
      ],
    );
  }
}