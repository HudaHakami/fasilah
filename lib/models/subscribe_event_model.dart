class SubscribeEventModel {
  String? time;
  String? uid;
  String? title;
  List? date;
  String? location;
  String? status;
  String? uidEvent;
  String? image;
  String? uidSubscribe;

  SubscribeEventModel({
    this.uid,
    this.title,
    this.date,
    this.time,
    this.location,
    this.status,
    this.uidEvent,
    this.image,
    this.uidSubscribe,

  });

  SubscribeEventModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    uid = json['uid'];
    time = json['time'];
    location = json['location'];
    date = json['date'];
    status = json['status'];
    uidEvent = json['uidEvent'];
    image = json['image'];
    uidSubscribe = json['uidSubscribe'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'uid': uid,
      'time': time,
      'location': location,
      'date': date,
      'status': status,
      'uidEvent': uidEvent,
      'image': image,
      'uidSubscribe': uidSubscribe,
    };
  }
}
