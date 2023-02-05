class User{
  String uid;
  String name;
  int age;
  String gender;
  int height;
  int weight;
  String schoolName;
  String classNumber;
  String div;
  String fatherName;
  String fatherContact;
  String motherName;
  String motherContact;
  String timeStamp;
  String? imageUrl;

  User(
      this.uid,
      this.name,
      this.age,
      this.gender,
      this.height,
      this.weight,
      this.schoolName,
      this.classNumber,
      this.div,
      this.fatherName,
      this.fatherContact,
      this.motherName,
      this.motherContact,
      this.timeStamp,
      this.imageUrl);

  User.fromJson(Map<dynamic, dynamic> json)
      : uid = json['uid'],
        name = json['name'],
        age=json['age'],
        gender=json['gender'],
        height=json['height'],
        weight=json['weight'],
        schoolName=json['schoolName'],
        classNumber=json['classNumber'],
        div=json['div'],
        fatherName=json['fatherName'],
        fatherContact=json['fatherContact'],
        motherContact=json['motherContact'],
        motherName=json['motherName'],
        timeStamp=json['timeStamp'],
        imageUrl=json['imageUrl'];


  Map<dynamic, dynamic> toMap() {
    return {
      'uid' : uid,
      'name' : name,
      'age':age,
      'gender':gender,
      'height':height,
      'weight':weight,
      'schoolName':schoolName,
      'classNumber':classNumber,
      'div':div,
      'fatherName':fatherName,
      'fatherContact':fatherContact,
      'motherContact':motherContact,
      'motherName':motherName,
      'timeStamp': timeStamp,
      'imageUrl': imageUrl
    };
  }
}