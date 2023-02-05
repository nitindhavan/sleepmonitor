import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sleepmonitor/models/User.dart' as user;
import 'package:sleepmonitor/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:sleepmonitor/screens/profile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key,required this.cuser}) : super(key: key);

  final user.User cuser;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  var nameController=TextEditingController();
  var ageController=TextEditingController();

  var gender='Male';
  var heightController= TextEditingController();
  var weightController=TextEditingController();

  var schoolController=TextEditingController();
  var classController=TextEditingController();
  var divisionController=TextEditingController();
  var fathersController=TextEditingController();
  var fathersContactController=TextEditingController();
  var motherNameController=TextEditingController();
  var motherContactController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text=widget.cuser.name;
    ageController.text=widget.cuser.age.toString();
    gender=widget.cuser.gender;
    heightController.text=widget.cuser.height.toString();
    weightController.text=widget.cuser.weight.toString();

    schoolController.text=widget.cuser.schoolName;
    classController.text=widget.cuser.classNumber;
    divisionController.text=widget.cuser.div;
    fathersController.text=widget.cuser.fatherName;
    fathersContactController.text=widget.cuser.fatherContact;
    motherNameController.text=widget.cuser.motherContact;
    motherContactController.text=widget.cuser.motherContact;
  }
  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff5f259f),
        appBar: AppBar(title: Text(local.editProfile,textAlign: TextAlign.center,),toolbarHeight: 80,centerTitle: true,elevation: 0,),
        body: Card(
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        children:[
                          CustomTextField(hint: local.name,controller: nameController,),
                          CustomTextField(hint: local.age,controller: ageController,type: TextInputType.number,),
                          Container(margin: EdgeInsets.all(16),width: double.infinity,child: Text(textAlign: TextAlign.left,local.selectGender,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),)),
                          Row(
                            children: [
                              Expanded(child: GestureDetector(onTap: (){
                                setState(() {
                                  gender='Male';
                                });
                              },child: Container(margin: EdgeInsets.only(left: 16,right: 16),padding:EdgeInsets.only(left: 16,right: 16),decoration: BoxDecoration(color: gender=='Male' ? Color(0xff5f259f) : Color(0xffe5e5ff),borderRadius: BorderRadius.circular(16)),height: 60,width: double.infinity,child: Center(child: Text(local.male,style: TextStyle(color: gender=='Male' ?  Colors.white : Colors.black,)))))),
                              Expanded(child: GestureDetector(onTap: (){
                                setState(() {
                                  gender='Female';
                                });
                              },child: Container(margin: EdgeInsets.only(left: 16,right: 16),padding:EdgeInsets.only(left: 16,right: 16),decoration: BoxDecoration(color: gender=='Female' ? Color(0xff5f259f) : Color(0xffe5e5ff),borderRadius: BorderRadius.circular(16)),height: 60,width: double.infinity,child: Center(child: Text(local.female,style: TextStyle(color: gender=='Female' ?  Colors.white : Colors.black,)))))),
                            ],
                          ),
                          Container(margin: EdgeInsets.all(16),width: double.infinity,child: Text(textAlign: TextAlign.left,local.heightWeight,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),)),
                          Row(
                            children: [
                              Expanded(child: Container(margin: EdgeInsets.only(left: 16,right: 16),padding:EdgeInsets.only(left: 16,right: 16),decoration: BoxDecoration(color:Color(0xffe5e5ff),borderRadius: BorderRadius.circular(16)),height: 60,width: double.infinity,child: Center(child: TextField(controller: heightController,keyboardType: TextInputType.number,decoration: InputDecoration(hintText: "Height",border: InputBorder.none),textAlign: TextAlign.center,)))),
                              Expanded(child: Container(margin: EdgeInsets.only(left: 16,right: 16),padding:EdgeInsets.only(left: 16,right: 16),decoration: BoxDecoration(color: Color(0xffe5e5ff),borderRadius: BorderRadius.circular(16)),height: 60,width: double.infinity,child: Center(child: TextField(controller: weightController,keyboardType: TextInputType.number,decoration: InputDecoration(hintText: "Weight",border: InputBorder.none),textAlign: TextAlign.center)))),
                            ],
                          ),
                          CustomTextField(hint: local.schoolName,controller: schoolController,),
                          CustomTextField(hint: local.standard,controller: classController,),
                          CustomTextField(hint: local.div,controller: divisionController,),
                          CustomTextField(hint: local.fathersName,controller: fathersController,),
                          CustomTextField(hint: local.fathersContact,controller: fathersContactController,type: TextInputType.phone,),
                          CustomTextField(hint: local.mothersName,controller: motherNameController,),
                          CustomTextField(hint: local.mothersContact,controller: motherContactController,type: TextInputType.phone,),
                          SizedBox(height: 16,),
                          GestureDetector(
                            onTap: (){
                              saveUser();
                            },
                            child: Container(
                              height: 60,
                              margin: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Color(0xff5f259f), borderRadius: BorderRadius.circular(32)),
                              child: Center(child: Text(local.continueText,style: TextStyle(color: Colors.white),)),
                            ),
                          ),
                          SizedBox(height: 32,),
                        ]
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveUser() {
    if(nameController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all the fields")));
      return;
    }

    if(ageController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill age")));
      return;
    }

    if(fathersContactController.text.length!=10 && fathersContactController.text.isNotEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fathers contact is incorrect")));
      return;
    }

    if(motherContactController.text.length!=10 && motherContactController.text.isNotEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Mothers contact is incorrect")));
      return;
    }

    var reference=FirebaseDatabase.instance.ref('users');
    var formatter=DateFormat('dd-MMM-yyyy');
    var cuser=user.User(FirebaseAuth.instance.currentUser!.uid, nameController.text, int.parse(ageController.text), gender, int.parse(heightController.text), int.parse(weightController.text), schoolController.text, classController.text, divisionController.text, fathersController.text, fathersContactController.text, motherNameController.text, motherContactController.text,formatter.format(DateTime.now()),null);
    reference.child(cuser.uid).set(cuser.toMap()).then((value){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Profile(user: cuser)));
    });
  }
}
class CustomTextField extends StatelessWidget {
  CustomTextField({Key? key, required this.hint,required this.controller,this.type}) : super(key: key);
  final String hint;
  final TextEditingController controller;
  TextInputType? type=TextInputType.text;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(margin: EdgeInsets.all(16),width: double.infinity,child: Text(textAlign: TextAlign.left,hint,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),)),
        Container(margin: EdgeInsets.only(left: 16,right: 16),padding:EdgeInsets.only(left: 16,right: 16),decoration: BoxDecoration(color: Color(0xffe5e5ff),borderRadius: BorderRadius.circular(16)),height: 60,width: double.infinity,child: Center(child: TextField(controller: controller,keyboardType: type,decoration: InputDecoration(hintText: "Enter $hint",border: InputBorder.none)))),

      ],
    );
  }
}

