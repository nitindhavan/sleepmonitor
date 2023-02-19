class Survey{
  String uid;
  String id;
  String week;
  DateTime dateTime;
  List<int> answers;

  Survey(this.uid, this.id, this.week, this.answers,this.dateTime);

  Survey.fromJson(Map<dynamic, dynamic> json)
      : uid = json['uid'],
        id=json['id'],
        week=json['week'],
  dateTime=DateTime.tryParse(json['dateTime']) ?? DateTime.now(),
        answers=json['answers'].cast<int>();


  Map<dynamic, dynamic> toMap() {
    return {
      'uid' : uid,
      'id': id,
      'week' : week,
      'answers': answers,
      'dateTime': dateTime.toIso8601String()
    };
  }

}