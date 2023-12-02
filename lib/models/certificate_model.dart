class CertificateModel {
  String? uid;
  String? nameStudent;
  String? nameCourse;
  String? uidCourse;
  String? certificate;
  String? uidSubscribe;

  CertificateModel({
    this.uid,
    this.nameStudent,
    this.uidSubscribe,
    this.uidCourse,
    this.certificate,
    this.nameCourse,
  });

  CertificateModel.fromJson(Map<String, dynamic> json) {

    uid = json['uid'];
    uidCourse = json['uidCourse'];
    uidSubscribe = json['uidSubscribe'];
    certificate = json['certificate'];
    nameStudent = json['nameStudent'];
    nameCourse = json['nameCourse'];

  }

  Map<String, dynamic> toMap() {
    return {
      'nameStudent': nameStudent,
      'uidCourse': uidCourse,
      'uidSubscribe': uidSubscribe,
      'certificate': certificate,
      'uid': uid,
      'nameCourse': nameCourse,
    };
  }
}
