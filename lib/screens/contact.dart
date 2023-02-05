import 'package:flutter/material.dart';
import 'package:sleepmonitor/models/Feedback.dart' as model;
import 'package:sleepmonitor/screens/home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  var feedbackController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff5f259f),
        appBar: AppBar(title: Text(local.contactUs,textAlign: TextAlign.center,),toolbarHeight: 80,centerTitle: true,elevation: 0,),
        body: Card(
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(local.contactUs,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w800,),),
                    Card(
                      color: Color(0xffe5e5ff),
                      margin: EdgeInsets.only(top: 16),
                      child: Container(
                        width: double.infinity,
                      child:Column(
                        children: [
                          Container(margin: EdgeInsets.only(top: 16,bottom: 16),child: Text(local.haveQuery,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w800,),)),
                          Icon(Icons.call,size: 100,),
                          Container(margin: EdgeInsets.only(top: 16,bottom: 16,left: 32,right: 32),child: Text(textAlign: TextAlign.center,local.chatWithUs,style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.normal,),)),
                          Container(margin: EdgeInsets.only(top: 16,bottom: 16,left: 32,right: 32),child: Text(textAlign: TextAlign.center,'sleephygiene134@gmail.com',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold,),)),
                          SizedBox(height: 16,),
                        ],
                      ),),
                    ),
                    SizedBox(height: 20,),
                    Text(local.feedback,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w800,),),
                    Card(
                      color: Color(0xffe5e5ff),
                      margin: EdgeInsets.only(top: 16),
                      child: Container(
                        width: double.infinity,
                        child: Container(margin: EdgeInsets.only(top: 16,bottom: 16),padding: EdgeInsets.only(left: 16,right: 16),child: TextField(controller: feedbackController,decoration: InputDecoration(hintText: local.writeFeedBack,border: InputBorder.none,),keyboardType: TextInputType.multiline,maxLines: 5,)),
                        ),
                    ),
                    SizedBox(height: 32,),
                    GestureDetector(
                      onTap: (){
                        saveFeedback();
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Color(0xff5f259f), borderRadius: BorderRadius.circular(32)),
                        child: Center(child: Text(local.submit,style: TextStyle(color: Colors.white),)),
                      ),
                    ),
                    SizedBox(height: 16,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void saveFeedback() async{

    if(feedbackController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please write something")));
    }
    var reference=FirebaseDatabase.instance.ref('feedback');
    model.Feedback feedback=model.Feedback(reference.push().key!, FirebaseAuth.instance.currentUser!.uid,feedbackController.text );

    reference.child(feedback.id).set(feedback.toMap()).then((value){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Thanks for the feedback !')));
      feedbackController.text='';
    });
  }
}
