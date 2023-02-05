class Survey{
  String uid;
  String id;
  String week;
  List<int> answers;

  Survey(this.uid, this.id, this.week, this.answers);

  Survey.fromJson(Map<dynamic, dynamic> json)
      : uid = json['uid'],
        id=json['id'],
        week=json['week'],
        answers=json['answers'].cast<int>();


  Map<dynamic, dynamic> toMap() {
    return {
      'uid' : uid,
      'id': id,
      'week' : week,
      'answers': answers
    };
  }

}