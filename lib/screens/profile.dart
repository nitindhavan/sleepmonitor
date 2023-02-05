import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sleepmonitor/models/User.dart';
import 'package:sleepmonitor/screens/editprofile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:sleepmonitor/screens/sign.dart';

import '../main.dart';class Profile extends StatefulWidget {
  const Profile({Key? key, required this.user}) : super(key: key);

  final User user;
  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {

  late File _imageFile;

  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Color(0xff5f259f),
      appBar: AppBar(title: Text(local.profile,textAlign: TextAlign.center,),toolbarHeight: 80,centerTitle: true,elevation: 0,),
      body: Card(
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.all(16),
                    child: GestureDetector(onTap:() async {
                      var sharep=await SharedPreferences.getInstance();
                      setState(() {
                        sharep.getString('languagecode')=='hi' ? sharep.setString('languagecode','en'): sharep.setString('languagecode','hi');
                        MyApp.of(context)?.setLocale(Locale.fromSubtags(languageCode: sharep.getString('languagecode')??'hi '));
                      });
                    },child: Container(height: 50,width: 50,decoration: BoxDecoration(color: Color(0xff5f259f),borderRadius: BorderRadius.circular(20)),child: Icon(Icons.language,color: Colors.white,),)),
                  ),
                  Container(
                    margin: EdgeInsets.all(16),
                    child: GestureDetector(onTap:(){
                      auth.FirebaseAuth.instance.signOut().then((value){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Sign()));
                      });
                    },child: Container(height: 50,width: 50,decoration: BoxDecoration(color: Color(0xff5f259f),borderRadius: BorderRadius.circular(20)),child: Icon(Icons.logout,color: Colors.white,),)),
                  ),
                ],
              ),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(100),
                    child: Container(height: 120,width: 120,padding: EdgeInsets.all(8),decoration: BoxDecoration(
                      color: Color(0xffe5e5ff),
                      borderRadius: BorderRadius.circular(120),
                    ),child: widget.user.imageUrl == null ? Image.asset('sleep.png') : ClipRRect(borderRadius: BorderRadius.circular(120),child: Image.network(widget.user.imageUrl!,fit: BoxFit.cover,height: 120,width: 120,)),),
                  ),
                  GestureDetector(
                      onTap: () async {
                        final picker = ImagePicker();
                          final pickedFile = await picker.getImage(source: ImageSource.gallery);
                          setState(() {
                            _imageFile = File(pickedFile!.path);
                          });
                          String fileName = widget.user.uid;
                          Reference firebaseStorageRef =
                          FirebaseStorage.instance.ref().child('uploads/$fileName');
                          firebaseStorageRef.putFile(_imageFile).then((p0){
                            p0.ref.getDownloadURL().then(
                                  (value) {
                                    widget.user.imageUrl=value;
                                    FirebaseDatabase.instance.ref('users').child(widget.user.uid).child('imageUrl').set(value).then((value){
                                      setState(() {
                                        widget.user.imageUrl;
                                      });
                                    });
                              },
                            );
                          });

                      },child: Container(height: 40,width: 40,decoration: BoxDecoration(color: Color(0xff5f259f),borderRadius: BorderRadius.circular(20)),child: Icon(Icons.edit,color: Colors.white,))),
                ],
              ),
              const SizedBox(height: 16,),
              // Text(widget.user.name,style: TextStyle(fontSize: 16),),
              const SizedBox(height: 32,),
              Card(
                margin: EdgeInsets.all(16),
                color: Color(0xffe5e5ff),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Text("${local.details} : ",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                        GestureDetector(onTap:(){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> EditProfile(cuser: widget.user)));
                        },child: Icon(Icons.edit)),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Text("${local.name} : ${widget.user.name}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    Text("${local.age} : ${widget.user.age}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    Text("${local.gender} : ${widget.user.gender == 'Male' ? local.male : local.female}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    Text("${local.heightWeight} : ${widget.user.height} cm & ${widget.user.weight} Kg",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    Text("${local.schoolName} : ${widget.user.schoolName}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    Text("${local.standard}: ${widget.user.classNumber}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    Text("${local.div} : ${widget.user.div}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    Text("${local.fathersName} : ${widget.user.fatherName}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    Text("${local.fathersContact} : ${widget.user.fatherContact}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    Text("${local.mothersName} : ${widget.user.motherName}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                    Text("${local.mothersContact} : ${widget.user.motherContact}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 16,),
                  ],
                ),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
