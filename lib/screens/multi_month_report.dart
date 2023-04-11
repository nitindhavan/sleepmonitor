import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sleepmonitor/models/Survey.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:animated_emoji/animated_emoji.dart';
class MultiMonthReport extends StatefulWidget {
  const MultiMonthReport({Key? key,required this.user}) : super(key: key);

  final String user;

  @override
  State<MultiMonthReport> createState() => _MultiMonthReportState();
}

class _MultiMonthReportState extends State<MultiMonthReport> {
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
              return Center(child: Text(local.noSurvey),);
            }else{
              List<Survey> surveyList=[];
              List<Widget> weekList=[];
              DateTime currentDate=DateTime.now();
              for(DataSnapshot snap in snapshot.data!.snapshot.children) {
                Survey survey = Survey.fromJson(snap.value as Map);
                if(survey.dateTime.month==currentDate.month)surveyList.add(survey);
              }

              surveyList.sort((a, b) => a.dateTime.compareTo(b.dateTime));

              int firstMonth=surveyList[0].dateTime.month;
              int secondMonth=firstMonth+1;
              int thirdMonth=secondMonth+1;
              if(firstMonth==11){
                thirdMonth=1;
              }else if(firstMonth==12){
                secondMonth=1;
                thirdMonth=2;
              }

              List<Survey> firstList=[];
              List<Survey> secondList=[];
              List<Survey> thirdList=[];

              for(Survey s in surveyList){
                if(s.dateTime.month==firstMonth) firstList.add(s);
                if(s.dateTime.month==secondMonth) secondList.add(s);
                if(s.dateTime.month==thirdMonth) thirdList.add(s);
              }

              for(int i=1 ; i<=12;i++){
                weekList.add(Expanded(child: Text('${local.month} $i',textAlign: TextAlign.center,),),);
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text(local.sleepDuration,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    Card(
                      color: Color(0xffe5e5ff),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Bar(height: averageDuration(firstList)*2,label: Text('${local.month} 1'),topLabel: Text('${averageDuration(firstList)}'),),
                            if(secondList.isNotEmpty)Bar(height: averageDuration(secondList)*2,label: Text('${local.month} 2'),topLabel: Text('${averageDuration(secondList)}'),),
                            if(thirdList.isNotEmpty)Bar(height: averageDuration(thirdList)*2,label: Text('${local.month} 3'),topLabel: Text('${averageDuration(thirdList)}'),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 32,),
                    Text(local.nap,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    Card(
                      color: Color(0xffe5e5ff),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 200,),
                            Bar(height: (getHeight(getNapData(firstList, 4)))*50,label: Text('${local.month} 1'),topLabel: Text(getNapData(firstList,4),)),
                            if(secondList.isNotEmpty)Bar(height: getHeight(getNapData(secondList,4))*50,label: Text('${local.month} 2'),topLabel: Text(getNapData(secondList,4),)),
                            if(thirdList.isNotEmpty)Bar(height: getHeight(getNapData(thirdList,4))*50,label: Text('${local.month} 3'),topLabel: Text(getNapData(thirdList,4),)),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 32,),
                    Text('${local.physical}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    Card(
                      color: Color(0xffe5e5ff),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 200,),
                            Bar(height: (getHeight(getNapData(firstList, 5)))*50,label: Text('${local.month} 1'),topLabel: Text(getNapData(firstList,5),)),
                            if(secondList.isNotEmpty)Bar(height: getHeight(getNapData(secondList, 5))*50,label: Text('${local.month} 2'),topLabel: Text(getNapData(secondList,5),)),
                            if(thirdList.isNotEmpty)Bar(height: getHeight(getNapData(secondList, 5))*50,label: Text('${local.month} 3'),topLabel: Text(getNapData(thirdList,5),)),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 32,),
                    Text(local.junkFood,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    Card(
                      color: Color(0xffe5e5ff),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 200,),
                            Bar(height: (getHeight(getNapData(firstList, 6)))*50,label: Text('${local.month} 1'),topLabel: Column(
                              children: [
                                ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('burger.png'),)),
                                SizedBox(height: 8,),
                                Text(getNapData(firstList,6),),
                              ],
                            )),
                            if(secondList.isNotEmpty)Bar(height: getHeight(getNapData(secondList, 6))*50,label: Text('${local.month} 2'),topLabel: Column(
                              children: [
                                ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('pizza.png'),)),
                                SizedBox(height: 8,),
                                Text(getNapData(secondList,6),),
                              ],
                            )),
                            if(thirdList.isNotEmpty)Bar(height: getHeight(getNapData(secondList, 6))*50,label: Text('${local.month} 3'),topLabel: Column(
                              children: [
                                ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('samosa.png'),)),
                                SizedBox(height: 8,),
                                Text(getNapData(thirdList,6),),
                              ],
                            )),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 32,),
                    Text(local.cafinatedBeverages,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    Card(
                      color: Color(0xffe5e5ff),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 200,),
                            Bar(height: (getHeight(getNapData(firstList, 7)))*50,label: Text('${local.month} 1'),topLabel: Column(
                              children: [
                                ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('can.png'),)),
                                SizedBox(height: 8,),
                                Text(getNapData(firstList,7),),
                              ],
                            )),
                            if(secondList.isNotEmpty)Bar(height: getHeight(getNapData(secondList, 7))*50,label: Text('${local.month} 2'),topLabel: Column(
                              children: [
                                ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('cofee.png'),)),
                                SizedBox(height: 8,),
                                Text(getNapData(secondList,7),),
                              ],
                            )),
                            if(thirdList.isNotEmpty)Bar(height: getHeight(getNapData(secondList, 7))*50,label: Text('${local.month} 3'),topLabel: Column(
                              children: [
                                ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('tea.png'),)),
                                SizedBox(height: 8,),
                                Text(getNapData(thirdList,7),),
                              ],
                            )),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 32,),
                    Text(local.mood,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    Card(
                      color: Color(0xffe5e5ff),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 200,),
                            Bar(height: (getHeight(getNapData(firstList, 8)))*50,label: Text('${local.month} 1'),topLabel: getMoodData(firstList,8,),color: Color(0xffe5e5ff),),
                            if(secondList.isNotEmpty)Bar(height: getHeight(getNapData(secondList, 8))*50,label: Text('${local.month} 2'),topLabel: getMoodData(secondList,8,),color: Color(0xffe5e5ff),),
                            if(thirdList.isNotEmpty)Bar(height: getHeight(getNapData(secondList, 8))*50,label: Text('${local.month} 3'),topLabel: getMoodData(thirdList,8,),color: Color(0xffe5e5ff),),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 32,),
                    Text(local.screenTime,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    Card(
                      color: Color(0xffe5e5ff),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 200,),
                            Bar(height: (getHeight(getNapData(firstList, 9)))*50,label: Text('${local.month} 1'),topLabel: Column(
                              children: [
                                ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('game.jpg'),)),
                                SizedBox(height: 8,),
                                Text(getScreenData(firstList,9),),
                              ],
                            )),
                            if(secondList.isNotEmpty)Bar(height: getHeight(getNapData(secondList, 9))*50,label: Text('${local.month} 2'),topLabel: Column(
                              children: [
                                ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('laptop.png'),)),
                                SizedBox(height: 8,),
                                Text(getScreenData(secondList,9),),
                              ],
                            )),
                            if(thirdList.isNotEmpty)Bar(height: getHeight(getNapData(secondList, 9))*50,label: Text('${local.month} 3'),topLabel: Column(
                              children: [
                                ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(color: Colors.white,height: 40,width: 40,child: Image.asset('phone.png'),)),
                                SizedBox(height: 8,),
                                Text(getScreenData(thirdList,9),),
                              ],
                            )),
                          ],
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

  int averageDuration(List<Survey> surveyList){
    int total=0;
    int count=0;
    for(Survey s in surveyList){
      total+= durationScore(s.answers);
      count++;
    }
    return total~/count;
  }
  int durationScore(List<int> answerList) {
    int totalDuration=63;
    totalDuration-= 5 * answerList[0];
    totalDuration+= 5 *answerList[1];
    totalDuration-= 2 * answerList[2];
    totalDuration+= 2 *answerList[3];
    return totalDuration;
  }

  String getNapData(List<Survey> surveyList,int index) {
    int total=0;
    int count=0;
    for(Survey s in surveyList){
      total+=s.answers[index];
      count++;
    }
    int answer=total~/count;
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

  int getHeight(String value){
    switch (value){
      case '0 times':
        return 0;
      case '1-2 Times':
        return 1;
      case '3-4 times':
        return 2;
      case '5-6 times':
        return 3;
      case '0-2 Hours':
        return 0;
      case '3-5 Hours':
        return 1;
      case '6-8 Hours':
        return 2;
      case '9-12 Hours':
        return 3;
      default:
        return 4;
    }
  }
  String getScreenData(List<Survey> surveyList,int index) {
    int total=0;
    int count=0;
    for(Survey s in surveyList){
      total+=s.answers[index];
      count++;
    }
    int answer=total~/count;
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
  Widget getMoodData(List<Survey> surveyList,int index) {
    int total=0;
    int count=0;
    for(Survey s in surveyList){
      total+=s.answers[index];
      count++;
    }
    int answer=total~/count;
    switch (answer){
      case 0:
        return Column(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(50),child : Container(color: Colors.white,child: Image.asset('energetic.gif',height: 50,width: 50))),
          ],
        );
      case 1:
        return Column(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(50),child : Container(color: Colors.white,child: Image.asset('calm.gif',height: 50,width: 50))),
          ],
        );
      case 2:
        return Column(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(50),child : Container(color: Colors.white,child: Image.asset('irritated.gif',height: 50,width: 50)),),
          ],
        );
      case 3:
        return Column(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(50),child : Container(color: Colors.white,child: Image.asset('anxious.gif',height: 50,width: 50))),
          ],
        );
      default:
        return Column(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(50),child : Container(color: Colors.white,child: Image.asset('woried.gif',height: 50,width: 50))),
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