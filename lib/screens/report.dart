import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sleepmonitor/screens/monthly_report.dart';

import '../models/User.dart';
import 'multi_month_report.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key,required this.answerList, required this.name,required this.user}) : super(key: key);

  final List<int> answerList;

  final String name;

  final String user;

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

  int isWeekly=0;
  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xff5f259f),
      appBar: AppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Text(local.report,textAlign: TextAlign.right,)),
          Expanded(child: GestureDetector(onTap: (){
            setState(() {
              isWeekly++;
              if(isWeekly==3) isWeekly=0;
            });
          },child: Container(alignment: Alignment.centerRight,child: Icon(Icons.change_circle_outlined,color: Colors.white,))))
        ],
      ),toolbarHeight: 80,centerTitle: true,elevation: 0,),
      body: isWeekly==0? Card(
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.only(top:16.0),
          child: SingleChildScrollView(
            child: Container(
              // decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
              // margin: EdgeInsets.all(16),
              // padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: Color(0xffe5e5ff),
                    margin: EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(local.sleepDuration,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(height: 32,),
                          Stack(
                            children: [
                              Container(height: 70,margin: EdgeInsets.only(top : 16,bottom: 16),decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.redAccent,Colors.greenAccent])),),
                              Column(
                                children: [
                                  Row(children: [
                                    Expanded(flex: durationScore(),child: SizedBox()),
                                    Column(
                                      children: [
                                        Container(width: 5,height: 100,color: Colors.black,),
                                        SizedBox(height: 20,),
                                      ],
                                    ),
                                    Expanded(flex: 70-durationScore(),child: SizedBox()),
                                  ],),
                                  Row(
                                    children: [
                                      Expanded(flex: durationScore(),child: SizedBox()),
                                      Text('${durationScore()} ${local.hours}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,),
                                      Expanded(flex: 70-durationScore(),child: SizedBox()),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16,),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: Color(0xffe5e5ff),
                    margin: EdgeInsets.all(16),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(local.sleepLag,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(height: 32,),
                          Stack(
                            children: [
                              Container(height: 70,margin: EdgeInsets.only(top : 16,bottom: 16),decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.green,Colors.red])),),
                              Column(
                                children: [
                                  Row(children: [
                                    Expanded(flex: 56-durationScore(),child: SizedBox()),
                                    Column(
                                      children: [
                                        Container(width: 5,height: 100,color: Colors.black,),
                                        SizedBox(height: 20,),
                                      ],
                                    ),
                                    Expanded(flex: 10-56-durationScore(),child: SizedBox()),
                                  ],),
                                  Row(
                                    children: [
                                      Expanded(flex: 56-durationScore(),child: SizedBox()),
                                      Text('${56 - durationScore() < 0 ? '0' : 56 - durationScore()} ${local.hours}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,),
                                      Expanded(flex: 10-56-durationScore(),child: SizedBox()),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Text(56-durationScore() > 0 ? "${local.shouldTake}" : "${widget.name} ${local.noLag}",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),
                          SizedBox(height: 16,),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(16),
                    color: Color(0xffe5e5ff),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${local.regularity} : ",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(height: 20,),
                          Text(regurality() ? "${widget.name} ${local.isRegular}" : "${widget.name} ${local.isIrregular}",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),
                          SizedBox(height: 16,),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: Color(0xffe5e5ff),
                    margin: EdgeInsets.all(16),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(local.sleepHygiene,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(height: 32,),
                          Stack(
                            children: [
                              Container(height: 70,margin: EdgeInsets.only(top : 16,bottom: 16),decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.redAccent,Colors.greenAccent])),),
                              Column(
                                children: [
                                  Row(children: [
                                    Expanded(flex: sleepHygine(),child: SizedBox()),
                                    Column(
                                      children: [
                                        Container(width: 5,height: 100,color: Colors.black,),
                                        SizedBox(height: 20,),
                                      ],
                                    ),
                                    Expanded(flex: 10-sleepHygine(),child: SizedBox()),
                                  ],),
                                  Row(
                                    children: [
                                      Expanded(flex: sleepHygine(),child: SizedBox()),
                                      Column(
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(60)
                                            ),
                                            child: ClipRRect(borderRadius: BorderRadius.circular(60),child: Image.asset(sleepHygine() >= 7 ? 'happy.png' : sleepHygine() >= 5 ? 'smile.png' : 'sademoji.png',height: 60,width: 60,)),
                                          ),
                                          SizedBox(height: 8,),
                                          Text('${local.score} : ${sleepHygine()}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,),
                                        ],
                                      ),
                                      Expanded(flex: 10-sleepHygine(),child: SizedBox()),
                                    ],
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(16),
                    color: Color(0xffe5e5ff),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(local.overallHealth,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(height: 32,),
                          Stack(
                            children: [
                              Container(height: 70,margin: EdgeInsets.only(top : 16,bottom: 16),decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.redAccent,Colors.greenAccent])),),
                              Column(
                                children: [
                                  Row(children: [
                                    Expanded(flex: grandTotal(),child: SizedBox()),
                                    Column(
                                      children: [
                                        Container(width: 5,height: 100,color: Colors.black,),
                                        SizedBox(height: 20,),
                                      ],
                                    ),
                                    Expanded(flex: 16-grandTotal(),child: SizedBox()),
                                  ],),
                                  Row(
                                    children: [
                                      Expanded(flex: grandTotal(),child: SizedBox()),
                                      Column(
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(60)
                                            ),
                                            child: ClipRRect(borderRadius: BorderRadius.circular(60),child: Image.asset(grandTotal() >= 11 ? 'happy.png' : grandTotal() >= 6 ? 'smile.png' : 'sademoji.png',height: 60,width: 60,)),
                                          ),
                                          SizedBox(height: 8,),
                                          Text('${local.score} : ${grandTotal()}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,),
                                        ],
                                      ),
                                      Expanded(flex: 16-grandTotal(),child: SizedBox()),
                                    ],
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ) : isWeekly==1 ? MonthlyReport(user: widget.user) : MultiMonthReport(user: widget.user,),
    ));
  }

  int durationScore() {
    int totalDuration=63;
    if(widget.answerList[0] != -1) {
      totalDuration -= 5 * widget.answerList[0];
    }else {
      return 0;
    }
      totalDuration+= 5 *widget.answerList[1];
      totalDuration-= 2 * widget.answerList[2];
      totalDuration+= 2 *widget.answerList[3];
      return totalDuration;
  }


  bool regurality(){
    return widget.answerList[0] - widget.answerList[1] == widget.answerList[2]- widget.answerList[3];
  }

  int grandTotal() {
    int total=0;
     if(widget.answerList[10]==0)total++;
     if(widget.answerList[11]==0)total++;
     if(widget.answerList[12]==0)total++;
     if(widget.answerList[13]==1)total++;
     if(widget.answerList[14]==1)total++;
     if(widget.answerList[15]==0)total++;
     if(widget.answerList[16]==1)total++;
     if(widget.answerList[17]==1)total++;
     if(widget.answerList[18]==1)total++;
     if(widget.answerList[19]==0)total++;

     if(durationScore() >= 56) total+=2;

     if(durationScore() >= 49 && (durationScore() < 56 )) total++;

     if(56 - durationScore() < 1) total+=2;

     if(56-durationScore() > 0 && 56-durationScore() <=7) total++;

     if(regurality()) total++;
     return total;
  }

  int sleepHygine() {
    int total=0;
    if(widget.answerList[10]==0)total++;
    if(widget.answerList[11]==0)total++;
    if(widget.answerList[12]==0)total++;
    if(widget.answerList[13]==1)total++;
    if(widget.answerList[14]==1)total++;
    if(widget.answerList[15]==0)total++;
    if(widget.answerList[16]==1)total++;
    if(widget.answerList[17]==1)total++;
    if(widget.answerList[18]==1)total++;
    if(widget.answerList[19]==0)total++;
    return total;
  }

}
