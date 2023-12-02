class EventModel {
  String? time;
  String? uid;
  String? title;
  List? date;
  List? subscribers;
  String? location;
  String? status;
  String? uidUser;
  String? image;
  String? numberAttendees;
  bool ?favourite;

  EventModel({
    this.uid,
    this.title,
    this.date,
    this.time,
    this.location,
    this.status,
    this.uidUser,
    this.image,
    this.numberAttendees,
    this.subscribers,
    this.favourite,
  });

  EventModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    uid = json['uid'];
    time = json['time'];
    location = json['location'];
    date = json['date'];
    status = json['status'];
    uidUser = json['uidUser'];
    image = json['image'];
    numberAttendees = json['numberAttendees'];
    subscribers = json['subscribers'];
    favourite = json['favourite'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'uid': uid,
      'time': time,
      'location': location,
      'date': date,
      'status': status,
      'uidUser': uidUser,
      'image': image,
      'numberAttendees': numberAttendees,
      'subscribers': subscribers,
      'favourite': favourite,
    };
  }
}
