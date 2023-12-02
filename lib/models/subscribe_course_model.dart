class SubscribeCourseModel {
  String? time;
  String? uid;
  String? nameInstructor;
  String? title;
  List? date;
  String? type;
  String? numOfStudent;
  String? location;
  String? uidUser;
  String? image;
  String? uidSubscribe;
  String? uidCourse;
  String? nameStudent;
  bool? certificate;

  SubscribeCourseModel({
    this.type,
    this.uid,
    this.title,
    this.date,
    this.time,
    this.location,
    this.nameInstructor,
    this.numOfStudent,
    this.uidUser,
    this.image,
    this.uidSubscribe,
    this.uidCourse,
    this.nameStudent,
    this.certificate,
  });

  SubscribeCourseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    uid = json['uid'];
    time = json['time'];
    nameInstructor = json['nameInstructor'];
    location = json['location'];
    date = json['date'];
    numOfStudent = json['numOfStudent'];

    uidUser = json['uidUser'];
    image = json['image'];
    uidSubscribe = json['uidSubscribe'];
    uidCourse = json['uidCourse'];
    nameStudent = json['nameStudent'];
    certificate = json['certificate'];
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
      'uidUser': uidUser,
      'image': image,
      'uidCourse': uidCourse,
      'uidSubscribe': uidSubscribe,
      'nameStudent': nameStudent,
      'certificate': certificate,
    };
  }
}
