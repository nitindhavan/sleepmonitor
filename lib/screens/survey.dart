import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleepmonitor/data/constants.dart';
import 'package:sleepmonitor/models/Question.dart';
import 'package:sleepmonitor/screens/completed.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Survey extends StatefulWidget {
  const Survey({Key? key,required this.name,required this.title,required this.week}) : super(key: key);

  final String name;

  final String title;

  final String week;
  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  int number=1;
  bool completed=false;

  int currentSelected=-1;


  List<int> answerList=[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];

  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context);
    return  SafeArea(

        child: Scaffold(
          backgroundColor: Color(0xff5f259f),
          appBar: AppBar(title: Text(widget.title,textAlign: TextAlign.center,),toolbarHeight: 80,centerTitle: true,elevation: 0,),
          body: Card(
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(onTap: (){
                        setState(() {
                          if(number>1) {
                            answerList[number-1] =currentSelected;
                            number--;
                            currentSelected=answerList[number-1];
                          }
                        });
                      },child: Container(height: 40,width: 40,child: Icon(Icons.arrow_left,color: Colors.white,),decoration: BoxDecoration(color:Color(0xff5f259f),borderRadius: BorderRadius.circular(40)),)),
                      Text("${local.question} $number",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                      GestureDetector(onTap: (){
                        setState(() {
                          if(number<21) {
                            answerList[number-1] =currentSelected;
                            if(currentSelected!=-1) {
                              number++;
                              currentSelected = answerList[number - 1];
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select something!')));
                            }
                          }else{
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CompletedScreen(answerList: answerList, name: widget.name,week: widget.week, title: widget.title,)));
                          }
                        });
                      },child: Container(height: 40,width: 40,child: Icon(Icons.arrow_right,color: Colors.white,),decoration: BoxDecoration(color: Color(0xff5f259f),borderRadius: BorderRadius.circular(40)),))
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      margin: EdgeInsets.all(8),
                      color:  Color(0xffe5e5ff),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SizedBox(height: 32,),
                            Text(local.localeName=='hi' ? hindiQuestion[number-1].question : questions[number-1].question,style: TextStyle(color: Colors.black,fontSize: 16),textAlign: TextAlign.justify,),
                            SizedBox(height: 32,),
                            Column(children : options(local.localeName=='hi' ? hindiQuestion[number-1] : questions[number-1])),
                            SizedBox(height: 32,),
                            // GestureDetector(
                            //   onTap: (){
                            //     setState(() {
                            //       if(number<21) {
                            //         answerList[number-1] =currentSelected;
                            //         number++;
                            //         currentSelected=-1;
                            //       }else{
                            //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CompletedScreen(answerList: answerList, name: widget.name,week: widget.week, title: widget.title,)));
                            //       }
                            //     });
                            //   },
                            //   child: Container(
                            //     height: 60,
                            //     decoration: BoxDecoration(
                            //         color: Colors.green.shade600, borderRadius: BorderRadius.circular(32)),
                            //     child: Center(child: Text(local.nextQuestion,style: TextStyle(color: Colors.white),)),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
        )
    );
  }

  List<Widget> options(Question current) {
    List<Widget> optionsList=[];
    for(var option in current.optionList){
      optionsList.add(GestureDetector(onTap: (){
        setState(() {
          currentSelected= current.optionList.indexOf(option);
          answerList[number-1] =currentSelected;
          Future.delayed(Duration(milliseconds: 300)).then((value){
            setState((){
              if(number<21) {
                if(currentSelected!=-1) {
                  number++;
                  currentSelected = answerList[number - 1];
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select something!')));
                }
              }else{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CompletedScreen(answerList: answerList, name: widget.name,week: widget.week, title: widget.title,)));
              }
            });
          });

      });
      },child: Container(padding: EdgeInsets.only(left: 16,right: 16),alignment: Alignment.centerLeft,width: double.infinity,margin: EdgeInsets.only(top: 8,bottom: 8),height:60,decoration: BoxDecoration(color:  current.optionList.indexOf(option)==currentSelected ? Color(0xff5f259f) : Colors.white, borderRadius: BorderRadius.circular(10),),child: Text(option,style: TextStyle(color: current.optionList.indexOf(option)==currentSelected ? Colors.white : Colors.black),),)));
    }
    return optionsList;
  }
}
