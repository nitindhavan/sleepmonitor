import 'package:flutter/material.dart';
import 'package:sleepmonitor/models/notification.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff5f259f),
        appBar: AppBar(title: Text(local.notifications,textAlign: TextAlign.center,),toolbarHeight: 80,centerTitle: true,elevation: 0,),
        body: Card(
          margin: EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
          child: FutureBuilder(builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
            if(!snapshot.hasData) return Center(child: CircularProgressIndicator(color: Color(0xff5f259f),));
            if(!snapshot.data!.snapshot.exists){
              return Center(child: Text(local.nonotifications,style: TextStyle(color: Colors.black),),);
            }
            List<NotificationModel> notifications=[];
            for(DataSnapshot snap in snapshot.data!.snapshot.children){
              NotificationModel model=NotificationModel.fromJson(snap.value as Map);
              notifications.add(model);
            }
            return Container(
                padding: EdgeInsets.all(16),
                child: ListView.builder(itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Color(0xffe5e5ff),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 8,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.notifications),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Container(margin: EdgeInsets.only(top: 8,bottom: 8,left: 16,right: 32),width: double.infinity,child: Text(textAlign: TextAlign.start,notifications[notifications.length-1-index].title,style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold,),)),
                                Container(margin: EdgeInsets.only(top: 0,bottom: 16,left: 16,right: 32),width: double.infinity,child: Text(textAlign: TextAlign.start,notifications[notifications.length-1-index].subtitle,style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.normal,),)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },itemCount: notifications.length,)
            );

          },future: FirebaseDatabase.instance.ref('notifications').once(),),
        ),
      ),
    );
  }
}
