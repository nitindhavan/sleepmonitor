class Feedback{
  String id;
  String uid;
  String feedback;

  Feedback(this.id, this.uid, this.feedback);

  Feedback.fromJson(Map<dynamic, dynamic> json)
      : uid = json['uid'],
        id=json['id'],
        feedback=json['feedback'];


  Map<dynamic, dynamic> toMap() {
    return {
      'uid' : uid,
      'id': id,
      'feedback': feedback
    };
  }

}