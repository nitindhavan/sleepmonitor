class NotificationModel{
  String id;
  String title;
  String subtitle;


  NotificationModel(this.id, this.title, this.subtitle);

  NotificationModel.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        title=json['title'],
        subtitle=json['subtitle'];


  Map<dynamic, dynamic> toMap() {
    return {
      'id': id,
      'title' : title,
      'subtitle': subtitle
    };
  }

}