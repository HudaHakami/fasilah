// ignore_for_file: body_might_complete_normally_catch_error, unused_import

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasilah_m1/models/user_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/certificate_model.dart';
import '../../../models/courses_model.dart';
import '../../../models/event_model.dart';
import '../../../models/subscribe_course_model.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());

  static AdminCubit get(context) => BlocProvider.of(context);
  List<CourseModel> courseList = [];
  List<CourseModel> acceptedCourseList = [];
  List<SubscribeCourseModel> subscribeCourseList = [];
  List<EventModel> eventList = [];
  List<EventModel> acceptedEventList = [];
  late List<DateTime?> datesList = [];
  List<CertificateModel> certificateList = [];
  String? certificateFile;
  File? certificateImageFile;
  String? certificateImage;
  UserModel? model;

  getData({required String uId}) {
    emit(GetDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then(
        (value) => {
              model = UserModel.fromJson(value.data()!),
              emit(GetDataSuccessState())
            });
  }

  getCourses() {
    emit(GetCourseLoadingState());
    FirebaseFirestore.instance
        .collection('courses')
        .where('status', isEqualTo: 'waiting')
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        Map<String, dynamic> docIsFav = element['favourite'];
        bool isFav = false;
        if (docIsFav
            .containsKey(FirebaseAuth.instance.currentUser!.uid.toString())) {
          isFav = docIsFav[FirebaseAuth.instance.currentUser!.uid.toString()];
        } else {
          isFav = false;
        }
        print(isFav);
        print("=============================");
        courseList = [];
        for (var element in event.docs) {
          courseList.add(CourseModel(
              uid: element.id,
              image: element['image'],
              title: element['title'],
              location: element['location'],
              status: element['status'],
              date: element['date'],
              time: element['time'],
              uidUser: element['uidUser'],
              type: element['type'],
              nameInstructor: element['nameInstructor'],
              numOfStudent: element['numOfStudent'],
              favourite: isFav));
        }
      }
      emit(GetCourseSuccessState());
    }).onError((error) {
      print(error.toString());
      emit(GetCourseErrorState(error.toString()));
    });
  }

  getAcceptedCourses() {
    emit(GetAcceptedCoursesLoadingState());
    FirebaseFirestore.instance
        .collection('courses')
        .where('status', isEqualTo: 'accept')
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        Map<String, dynamic> docIsFav = element['favourite'];
        bool isFav = false;
        if (docIsFav
            .containsKey(FirebaseAuth.instance.currentUser!.uid.toString())) {
          isFav = docIsFav[FirebaseAuth.instance.currentUser!.uid.toString()];
        } else {
          isFav = false;
        }
        print(isFav);
        print("=============================");
        acceptedCourseList = [];
        for (var element in event.docs) {
          acceptedCourseList.add(CourseModel(
              uid: element.id,
              image: element['image'],
              title: element['title'],
              location: element['location'],
              status: element['status'],
              date: element['date'],
              time: element['time'],
              uidUser: element['uidUser'],
              type: element['type'],
              nameInstructor: element['nameInstructor'],
              numOfStudent: element['numOfStudent'],
              favourite: isFav));
        }
      }
      emit(GetAcceptedCoursesSuccessState());
    }).onError((error) {
      print(error.toString());
      emit(GetAcceptedCoursesErrorState(error.toString()));
    });
  }

  acceptCourse({required String uidDoc}) {
    emit(AcceptCoursesLoadingState());
    FirebaseFirestore.instance
        .collection('courses')
        .doc(uidDoc)
        .update({'status': 'accept'}).then((value) {
      emit(AcceptCoursesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AcceptCoursesErrorState(error.toString()));
    });
  }

  refuseCourse({required String uidDoc}) {
    emit(RefuseCoursesLoadingState());
    FirebaseFirestore.instance
        .collection('courses')
        .doc(uidDoc)
        .update({'status': 'refuse'}).then((value) {
      emit(RefuseCoursesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RefuseCoursesErrorState(error.toString()));
    });
  }

  deleteCourse({required String uidDoc}) {
    emit(DeleteCoursesLoadingState());
    FirebaseFirestore.instance
        .collection('courses')
        .doc(uidDoc)
        .delete()
        .then((value) {
      emit(DeleteCoursesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DeleteCoursesErrorState(error.toString()));
    });
  }

  stopCourse({required String uidDoc}) {
    emit(StopCoursesLoadingState());
    FirebaseFirestore.instance
        .collection('courses')
        .doc(uidDoc)
        .update({'status': 'stop'}).then((value) {
      emit(StopCoursesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(StopCoursesErrorState(error.toString()));
    });
  }

  getEvents() {
    emit(GetEventsLoadingState());
    FirebaseFirestore.instance
        .collection('events')
        .where('status', isEqualTo: 'waiting')
        .snapshots()
        .listen((event) {
      eventList = [];
      for (var element in event.docs) {
        eventList.add(EventModel(
            uid: element.id,
            image: element['image'],
            title: element['title'],
            location: element['location'],
            date: element['date'],
            status: element['status'],
            time: element['time'],
            uidUser: element['uidUser'],
            subscribers: element['subscribers'],
            numberAttendees: element['numberAttendees']));
      }

      emit(GetEventsSuccessState());
    }).onError((error) {
      print(error.toString());
      emit(GetEventsErrorState(error.toString()));
    });
  }

  getAcceptedEvents() {
    emit(GetAcceptedEventsLoadingState());
    FirebaseFirestore.instance
        .collection('events')
        .where('status', isEqualTo: 'accept')
        .snapshots()
        .listen((event) {
      acceptedEventList = [];
      for (var element in event.docs) {
        acceptedEventList.add(EventModel(
            uid: element.id,
            image: element['image'],
            title: element['title'],
            location: element['location'],
            status: element['status'],
            date: element['date'],
            time: element['time'],
            uidUser: element['uidUser'],
            subscribers: element['subscribers'],
            numberAttendees: element['numberAttendees']));
      }

      emit(GetAcceptedEventsSuccessState());
    }).onError((error) {
      print(error.toString());
      emit(GetAcceptedEventsErrorState(error.toString()));
    });
  }

  acceptEvent({required String uidDoc}) {
    emit(AcceptEventsLoadingState());
    FirebaseFirestore.instance
        .collection('events')
        .doc(uidDoc)
        .update({'status': 'accept'}).then((value) {
      emit(AcceptEventsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AcceptEventsErrorState(error.toString()));
    });
  }

  refuseEvent({required String uidDoc}) {
    emit(RefuseEventsLoadingState());
    FirebaseFirestore.instance
        .collection('events')
        .doc(uidDoc)
        .update({'status': 'refuse'}).then((value) {
      emit(RefuseEventsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RefuseEventsErrorState(error.toString()));
    });
  }

  deleteEvent({required String uidDoc}) {
    emit(DeleteEventsLoadingState());
    FirebaseFirestore.instance
        .collection('events')
        .doc(uidDoc)
        .delete()
        .then((value) {
      emit(DeleteEventsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DeleteEventsErrorState(error.toString()));
    });
  }

  stopEvent({required String uidDoc}) {
    emit(StopEventsLoadingState());
    FirebaseFirestore.instance
        .collection('events')
        .doc(uidDoc)
        .update({'status': 'stop'}).then((value) {
      emit(StopEventsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(StopEventsErrorState(error.toString()));
    });
  }

  getEnrolled({required String uidDoc}) {
    emit(EnrolledCoursesLoadingState());
    FirebaseFirestore.instance
        .collection('coursesSubscribe')
        .where('uidCourse', isEqualTo: uidDoc)
        .get()
        .then((value) => {
              subscribeCourseList = [],
              for (var element in value.docs)
                {
                  subscribeCourseList.add(SubscribeCourseModel(
                    uid: element.id,
                    image: element['image'],
                    title: element['title'],
                    location: element['location'],
                    date: element['date'],
                    time: element['time'],
                    uidUser: element['uidUser'],
                    type: element['type'],
                    nameInstructor: element['nameInstructor'],
                    numOfStudent: element['numOfStudent'],
                    uidCourse: element['uidCourse'],
                    uidSubscribe: element['uidSubscribe'],
                    nameStudent: element['nameStudent'],
                    certificate: element['certificate'],
                  )),
                },
              emit(EnrolledCoursesSuccessState()),
            })
        .catchError((error) {
      emit(EnrolledCoursesErrorState(error.toString()));
    });
  }

  uploadCertificate({
    required String nameStudent,
    required String uidCourse,
    required String uidSubscribe,
    required String docUid,
    required String nameCourse,
  }) {
    emit(UploadCertificateLoadingState());
    FirebaseFirestore.instance
        .collection('certificates')
        .add({
          'nameStudent': nameStudent,
          'uidCourse': uidCourse,
          'uidSubscribe': uidSubscribe,
          'certificate': certificateImage,
          'nameCourse': nameCourse,
        })
        .then((value) => {
              FirebaseFirestore.instance
                  .collection('coursesSubscribe')
                  .doc(docUid)
                  .update({
                'certificate': true,
              }),
              emit(UploadCertificateSuccessState()),
            })
        .catchError((error) {
          emit(UploadCertificateErrorState(error.toString()));
        });
  }

  // function to upload image
  showBottomSheet(
    BuildContext context,
  ) {
    ImagePicker picker = ImagePicker();
    XFile? file;
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: 190,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Please Choose Image",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () async {
                    file = await picker.pickImage(source: ImageSource.gallery);

                    Navigator.pop(context);
                    getLicenseImage(
                      file,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.photo_outlined,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "From Gallery",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    file = await picker.pickImage(source: ImageSource.camera);
                    Navigator.pop(context);
                    getLicenseImage(
                      file,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.camera,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "From Camera",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> getLicenseImage(
    final file,
  ) async {
    if (file != null) {
      certificateImageFile = File(file.path);
      if (kDebugMode) {
        print(file.path);
      }
      emit(GetImageSuccessState());
      uploadImageLicense();
    } else {
      if (kDebugMode) {
        emit(GetImageErrorState('No image selected'));
        print('No image selected');
      }
    }
  }

  void uploadImageLicense() {
    emit(UploadCertificateImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child(
            '/image${Uri.file(certificateImageFile!.path).pathSegments.last}')
        .putFile(certificateImageFile!)
        .then((value) {
      if (kDebugMode) {
        print(value);
      }
      value.ref.getDownloadURL().then((value) {
        certificateImage = value;
      }).catchError((error) {
        emit(UploadCertificateImageErrorState(error.toString()));
      });

      emit(UploadCertificateImageSuccessState());
    }).catchError((error) {
      emit(UploadCertificateImageErrorState(error.toString()));
    });
  }

  getCertificates() {
    emit(GetCertificatesLoadingState());
    FirebaseFirestore.instance
        .collection('certificates')
        .snapshots()
        .listen((event) {
      certificateList = [];
      for (var element in event.docs) {
        certificateList.add(CertificateModel(
          uid: element.id,
          certificate: element['certificate'],
          nameStudent: element['nameStudent'],
          uidSubscribe: element['uidSubscribe'],
          uidCourse: element['uidCourse'],
          nameCourse: element['nameCourse'],
        ));
      }
      emit(GetCertificatesSuccessState());
    }).onError((error) {
      emit(GetCertificatesErrorState(error.toString()));
    });
  }

  // function to upload CV

  // Future<File?> pickPDFFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );
  //   if (result != null) {
  //     File file = File(result.files.single.path!);
  //     return file;}
  //   return null;}
  // void uploadFile() async {
  //   emit(UploadCertificateImageLoadingState());
  //   File? file = await pickPDFFile();
  //   if (file != null) {
  //     certificateFile = await uploadPDFToFirebaseStorage(file);
  //     if (certificateFile != null) {
  //       emit(UploadCertificateImageSuccessState());
  //       debugPrint('File uploaded successfully. Download URL: $certificateFile');
  //     } else {
  //       debugPrint('File upload failed.');
  //     }}}
  // Future<String?> uploadPDFToFirebaseStorage(File file) async {
  //   try {
  //     String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //     Reference reference =
  //     FirebaseStorage.instance.ref().child('pdfs/$fileName.pdf');
  //     TaskSnapshot snapshot = await reference.putFile(file);
  //     String downloadUrl = await snapshot.ref.getDownloadURL();
  //     return downloadUrl;
  //   } catch (error) {
  //     emit(UploadCertificateImageErrorState(error.toString()));
  //     debugPrint(error.toString());
  //     return null;
  //   }
  // }
}
