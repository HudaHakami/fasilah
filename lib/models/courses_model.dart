
class CourseModel {
  String ? time;
  String? uid;
  String? nameInstructor;
  String? title;
  List? date;
  String? type;
  String? numOfStudent;
  String? location;
  String? status;
  String? uidUser;
  String? image;
  List? subscribers;
  bool ? favourite;
  CourseModel({
    this.type,
    this.uid,
    this.title,
    this.date,
    this.time,
    this.location,
    this.nameInstructor,
    this.numOfStudent,
    this.status,
    this.uidUser,
    this.image,
    this.subscribers,
    this.favourite,
  });

  CourseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    uid = json['uid'];
    time = json['time'];
    nameInstructor = json['nameInstructor'];
    location = json['location'];
    date = json['date'];
    numOfStudent = json['numOfStudent'];
    status = json['status'];
    uidUser = json['uidUser'];
    image = json['image'];
    subscribers = json['subscribers'];
    favourite = json['favourite'];


  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'title': title,
      'uid': uid,
      'time': time,
      'nameInstructor': nameInstructor,
      'location': location,
      'date': date,
      'numOfStudent': numOfStudent,
      'status': status,
      'uidUser': uidUser,
      'image': image,
      'subscribers': subscribers,
      'favourite': favourite,
    };
  }
}
