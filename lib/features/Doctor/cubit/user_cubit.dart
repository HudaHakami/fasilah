// ignore_for_file: body_might_complete_normally_catch_error, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasilah_m1/models/certificate_model.dart';
import 'package:fasilah_m1/models/event_model.dart';
import 'package:fasilah_m1/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/courses_model.dart';
import '../../../models/subscribe_course_model.dart';
import '../../../models/subscribe_event_model.dart';
import '../../../shared/network/local/constant.dart';
import '../certificate/view.dart';
import '../home/view.dart';
import '../request/view.dart';
import '../subscriptions_doctor/view.dart';
import '../subscriptions_student/view.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of(context);

  File? courseImageFile;
  String? courseImage;
  List<CourseModel> coursesList = [];
  List<CourseModel> myAcceptedCoursesList = [];
  List<CourseModel> myRefusedCoursesList = [];
  List<CourseModel> myWaitingCoursesList = [];
  List<CourseModel> favouriteCoursesList = [];
  List<EventModel> eventsList = [];
  List<EventModel> eventsVisitorList = [];
  List<EventModel> myAcceptedEventsList = [];
  List<EventModel> myRefusedEventsList = [];
  List<EventModel> myWaitingEventsList = [];
  List<EventModel> favouriteEventList = [];
  List<SubscribeCourseModel> coursesSubscriberList = [];
  List<CourseModel> oldCoursesSubscriberStudentList = [];
  List<CourseModel> newCoursesSubscriberStudentList = [];
  List<EventModel> oldEventsSubscriberStudentList = [];
  List<EventModel> newEventsSubscriberStudentList = [];
  List<SubscribeEventModel> eventsSubscriberList = [];
  List<CertificateModel> certificateList = [];
  UserModel? model;

  getData() {
    emit(GetDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then(
        (value) => {
              model = UserModel.fromJson(value.data()!),
              emit(GetDataSuccessState())
            });
  }

  updateProfile({
    required String name,
    required String email,
    required String uid,
  }) {
    emit(UpdateProfileLoadingState());
    FirebaseAuth.instance.currentUser!.updateEmail(email);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update({
          'email': email,
          'name': name,
        })
        .then((value) => {
              getData(),
              emit(UpdateProfileSuccessState()),
            })
        .catchError((error) {
          emit(UpdateProfileErrorState(error.toString()));
        });
  }

  int currentIndex = 0;

  List<StatefulWidget> pages = [
    const DoctorHomeScreen(),
    const SubscriptionDoctorScreen(),
    const RequestScreen(),
    const MyCertificate(),
  ];
  List<StatefulWidget> pagesStudent = [
    const DoctorHomeScreen(),
    const SubscriptionStudentScreen(),
    const RequestScreen(),
    const MyCertificate(),
  ];

  void changeBottomNavDoctor(int index) {
    if (index == 0) {
      getData();
      getCoursesAndEvents();
    }
    if (index == 1) {
      getCoursesAndEventsSubscription();
    }
    if (index == 2) {
      getMyCoursesAndEvents();
    }
    if (index == 3) {
      getMyCoursesAndEvents();
      getCertificates();
    }

    currentIndex = index;
    emit(ChangeBottomNavState());
  }
  void changeBottomNavStudent(int index) {
    if (index == 0) {
      getData();
      getCoursesAndEvents();
    }
    if (index == 1) {
      getCoursesAndEventsStudentSubscription();
    }
    if (index == 2) {
      getMyCoursesAndEvents();
    }
    if (index == 3) {
      getCertificates();
    }

    currentIndex = index;
    emit(ChangeBottomNavState());
  }

// Start : Function for add Course and Events
  addCourse({
    required String time,
    required String nameInstructor,
    required String title,
    required List date,
    required String type,
    required String numOfStudent,
    required String location,
    required String uidUser,
  }) {
    emit(AddCourseLoadingState());
    FirebaseFirestore.instance
        .collection('courses')
        .add({
          'type': type,
          'title': title,
          'time': time,
          'nameInstructor': nameInstructor,
          'location': location,
          'date': date,
          'numOfStudent': numOfStudent,
          'status': 'waiting',
          'uidUser': uidUser,
          'image': courseImage,
          'subscribers': [],
          'favourite': {},
        })
        .then((value) => {emit(AddCourseSuccessState())})
        .catchError((error) {
          emit(AddCourseErrorState(error.toString()));
        });
  }

  addEvent({
    required String time,
    required String title,
    required List<String> date,
    required String location,
    required String uidUser,
  }) {
    emit(AddEventLoadingState());
    FirebaseFirestore.instance
        .collection('events')
        .add({
          'title': title,
          'time': time,
          'location': location,
          'date': date,
          'status': 'waiting',
          'uidUser': uidUser,
          'image': courseImage,
          'subscribers': [],
          'numberAttendees': '0',
          'favourite': {},
        })
        .then((value) => {
              emit(AddEventSuccessState()),
            })
        .catchError((error) {
          emit(AddEventErrorState(error.toString()));
        });
  }

// End : Function for add Course and Events

  // Start function for upload image
  showBottomSheet(BuildContext context) {
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
                    getLicenseImage(file);
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
                    getLicenseImage(file);
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

  Future<void> getLicenseImage(final file) async {
    if (file != null) {
      courseImageFile = File(file.path);
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
    emit(UploadCourseImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('/license${Uri.file(courseImageFile!.path).pathSegments.last}')
        .putFile(courseImageFile!)
        .then((value) {
      if (kDebugMode) {
        print(value);
      }
      value.ref.getDownloadURL().then((value) {
        courseImage = value;
      }).catchError((error) {
        emit(UploadCourseImageErrorState(error.toString()));
      });
      emit(UploadCourseImageSuccessState());
    }).catchError((error) {
      emit(UploadCourseImageErrorState(error.toString()));
    });
  }

  // End function for upload image

  // Start function for  getCoursesAndEvents

  getCoursesAndEvents() {
    emit(GetCoursesAndEventsLoadingState());
    FirebaseFirestore.instance
        .collection('courses')
        .where('status', isEqualTo: 'accept')
        .snapshots()
        .listen((event) {
      coursesList = [];
      for (var element in event.docs) {
        Map<String, dynamic> docIsFav = element['favourite'];
        bool isFav = false;
        if (docIsFav.containsKey(
            FirebaseAuth.instance.currentUser!.uid.toString())) {
          isFav = docIsFav[FirebaseAuth.instance.currentUser!.uid.toString()];
        } else {
          isFav = false;
        }
        coursesList.add(CourseModel(
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
            subscribers: element['subscribers'],
            favourite: isFav ));
      }
    }).onError((error) {
      emit(GetCoursesAndEventsErrorState(error.toString()));
    });
    FirebaseFirestore.instance
        .collection('events')
        .where('status', isEqualTo: 'accept')
        .snapshots()
        .listen((event) {
      eventsList = [];
      for (var element in event.docs) {

        Map<String, dynamic> docIsFav = element['favourite'];
        bool isFav = false;
        if (docIsFav.containsKey(
            FirebaseAuth.instance.currentUser!.uid.toString())) {
          isFav = docIsFav[FirebaseAuth.instance.currentUser!.uid.toString()];
        } else {
          isFav = false;
        }
        eventsList.add(EventModel(
            uid: element.id,
            image: element['image'],
            title: element['title'],
            location: element['location'],
            status: element['status'],
            date: element['date'],
            time: element['time'],
            uidUser: element['uidUser'],
            numberAttendees: element['numberAttendees'],
            subscribers: element['subscribers'],
            favourite: isFav));
        print(
          element['subscribers'],
        );
      }

      emit(GetCoursesAndEventsSuccessState());
    }).onError((error) {
      print(error.toString());
      emit(GetCoursesAndEventsErrorState(error.toString()));
    });
  }

  // End function for  getCoursesAndEvents

  // Start function for  subscribe course and events

  subscribeCourse({
    required String time,
    required String nameInstructor,
    required String title,
    required List date,
    required String type,
    required String numOfStudent,
    required String location,
    required String uidUser,
    required String uidSubscribe,
    required String uidCourse,
    required String courseImage,
    required String nameStudent,
    required List subscribers,
  }) {
    emit(SubscribeCourseLoadingState());
    FirebaseFirestore.instance
        .collection('coursesSubscribe')
        .add({
          'type': type,
          'title': title,
          'time': time,
          'nameInstructor': nameInstructor,
          'location': location,
          'date': date,
          'numOfStudent': numOfStudent,
          'uidUser': uidUser,
          'uidSubscribe': uidSubscribe,
          'uidCourse': uidCourse,
          'image': courseImage,
          'nameStudent': nameStudent,
          'certificate': false,
        })
        .then((value) => {
              FirebaseFirestore.instance
                  .collection('courses')
                  .doc(uidCourse)
                  .update({
                'numOfStudent': numOfStudent,
                'subscribers': subscribers,
              }),
              emit(SubscribeCourseSuccessState())
            })
        .catchError((error) {
          emit(SubscribeCourseErrorState(error.toString()));
        });
  }

  subscribeEvent({
    required String time,
    required String title,
    required List date,
    required String numberAttendees,
    required String location,
    required String uidSubscribe,
    required String uidEvent,
    required String eventImage,
    required List subscribers,
  }) {
    emit(SubscribeEventLoadingState());
    FirebaseFirestore.instance
        .collection('eventsSubscribe')
        .add({
          'title': title,
          'time': time,
          'location': location,
          'date': date,
          'uidSubscribe': uidSubscribe,
          'uidEvent': uidEvent,
          'image': eventImage,
        })
        .then((value) => {
              FirebaseFirestore.instance
                  .collection('events')
                  .doc(uidEvent)
                  .update({
                'numberAttendees': numberAttendees,
                'subscribers': subscribers,
              }),
              emit(SubscribeEventSuccessState())
            })
        .catchError((error) {
          emit(SubscribeEventErrorState(error.toString()));
        });
  }

  // End function for  subscribe course and events

  // Start function for  get subscribe course and events

  getCoursesAndEventsSubscription() {
    emit(GetCoursesAndEventsSubscribeLoadingState());
    FirebaseFirestore.instance
        .collection('coursesSubscribe')
        .where('uidSubscribe', isEqualTo: uId)
        .snapshots()
        .listen((event) {
      coursesSubscriberList = [];
      for (var element in event.docs) {
        coursesSubscriberList.add(SubscribeCourseModel(
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
          certificate: element['certificate'],
          nameStudent: element['nameStudent'],
          uidCourse: element['uidCourse'],
          uidSubscribe: element['uidSubscribe'],
        ));
      }
    }).onError((error) {
      emit(GetCoursesAndEventsSubscribeErrorState(error.toString()));
    });
    FirebaseFirestore.instance
        .collection('eventsSubscribe')
        .where('uidSubscribe', isEqualTo: uId)
        .snapshots()
        .listen((event) {
      eventsSubscriberList = [];
      for (var element in event.docs) {
        eventsSubscriberList.add(SubscribeEventModel(
          uid: element.id,
          image: element['image'],
          title: element['title'],
          location: element['location'],
          date: element['date'],
          time: element['time'],
          uidEvent: element['uidEvent'],
          uidSubscribe: element['uidSubscribe'],
        ));
      }
      emit(GetCoursesAndEventsSubscribeSuccessState());
    }).onError((error) {
      emit(GetCoursesAndEventsErrorState(error.toString()));
    });
  }
// End  function for  get subscribe course and events

  // Start function for  get subscribe course and events for student

  getCoursesAndEventsStudentSubscription() {
    emit(GetCoursesAndEventsSubscribeLoadingState());
    FirebaseFirestore.instance
        .collection('courses')
        .where('status' , isEqualTo: 'stop' )
        .snapshots()
        .listen((event) {
      oldCoursesSubscriberStudentList = [];

      for (var element in event.docs) {
        List subscriber =  element['subscribers'];
        if(subscriber.contains(uId)){
          Map<String, dynamic> docIsFav = element['favourite'];
          bool isFav = false;
          if (docIsFav.containsKey(
              FirebaseAuth.instance.currentUser!.uid.toString())) {
            isFav = docIsFav[FirebaseAuth.instance.currentUser!.uid.toString()];
          } else {
            isFav = false;
          }
          print(isFav);
          print("=============================");
          oldCoursesSubscriberStudentList.add(CourseModel(
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
              subscribers: element['subscribers'],
              favourite: isFav ));
        }
      }
    }).onError((error){
      emit(GetCoursesAndEventsErrorState(error.toString()));
    });
    FirebaseFirestore.instance
        .collection('courses')
        .where('status' , isEqualTo: 'accept' ).orderBy('date' , descending: true)
        .snapshots()
        .listen((event) {
      newCoursesSubscriberStudentList = [];
      for (var element in event.docs) {
        List subscriber =  element['subscribers'];
        if(subscriber.contains(uId)){
          Map<String, dynamic> docIsFav = element['favourite'];
          bool isFav = false;
          if (docIsFav.containsKey(
              FirebaseAuth.instance.currentUser!.uid.toString())) {
            isFav = docIsFav[FirebaseAuth.instance.currentUser!.uid.toString()];
          } else {
            isFav = false;
          }
          print(isFav);
          print("=============================");
          newCoursesSubscriberStudentList.add(CourseModel(
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
              subscribers: element['subscribers'],
              favourite: isFav ));
        }
      }
    }).onError((error){
      emit(GetCoursesAndEventsErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('events')
        .where('status' , isEqualTo: 'stop' )
        .snapshots()
        .listen((event) {
      oldEventsSubscriberStudentList = [];

      for (var element in event.docs) {
        List subscriber =  element['subscribers'];
        if(subscriber.contains(uId)){
          Map<String, dynamic> docIsFav = element['favourite'];
          bool isFav = false;
          if (docIsFav.containsKey(
              FirebaseAuth.instance.currentUser!.uid.toString())) {
            isFav = docIsFav[FirebaseAuth.instance.currentUser!.uid.toString()];
          } else {
            isFav = false;
          }
          print(isFav);
          print("=============================");
          oldEventsSubscriberStudentList.add(EventModel(
              uid: element.id,
              image: element['image'],
              title: element['title'],
              location: element['location'],
              status: element['status'],
              date: element['date'],
              time: element['time'],
              uidUser: element['uidUser'],
              numberAttendees: element['numberAttendees'],
              subscribers: element['subscribers'],
              favourite: isFav
          ));
        }
      }
    }).onError((error){
      emit(GetCoursesAndEventsErrorState(error.toString()));
    });
    FirebaseFirestore.instance
        .collection('events')
        .where('status' , isEqualTo: 'accept' ).orderBy('date' , descending: true)
        .snapshots()
        .listen((event) {
      newEventsSubscriberStudentList = [];
      for (var element in event.docs) {
        List subscriber =  element['subscribers'];
        if(subscriber.contains(uId)){
          Map<String, dynamic> docIsFav = element['favourite'];
          bool isFav = false;
          if (docIsFav.containsKey(
              FirebaseAuth.instance.currentUser!.uid.toString())) {
            isFav = docIsFav[FirebaseAuth.instance.currentUser!.uid.toString()];
          } else {
            isFav = false;
          }
          print(isFav);
          print("=============================");
          newEventsSubscriberStudentList.add(EventModel(
              uid: element.id,
              image: element['image'],
              title: element['title'],
              location: element['location'],
              status: element['status'],
              date: element['date'],
              time: element['time'],
              uidUser: element['uidUser'],
              numberAttendees: element['numberAttendees'],
              subscribers: element['subscribers'],
              favourite: isFav
          ));
        }
      }
    }).onError((error){
      emit(GetCoursesAndEventsErrorState(error.toString()));
    });


  }

// End  function for  get subscribe course and events for student

  //   Start function for  get my course and events
  getMyCoursesAndEvents() {
    emit(GetCoursesAndEventsLoadingState());
    FirebaseFirestore.instance
        .collection('courses')
        .where('status', isEqualTo: 'accept')
        .where('uidUser', isEqualTo: uId)
        .snapshots()
        .listen((event) {

      myAcceptedCoursesList = [];

      for (var element in event.docs) {
        Map<String, dynamic> docIsFav = element['favourite'];
        bool isFav = false;
        if (docIsFav.containsKey(
            FirebaseAuth.instance.currentUser!.uid.toString())) {
          isFav = docIsFav[FirebaseAuth.instance.currentUser!.uid.toString()];
        } else {
          isFav = false;
        }
        myAcceptedCoursesList.add(CourseModel(
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
          favourite: isFav
        ));
      }
    });
    FirebaseFirestore.instance
        .collection('courses')
        .where('status', isEqualTo: 'refuse')
        .where('uidUser', isEqualTo: uId)
        .snapshots()
        .listen((event) {
      myRefusedCoursesList = [];
      for (var element in event.docs) {
        Map<String, dynamic> docIsFav = element['favourite'];
        bool isFav = false;
        if (docIsFav.containsKey(
            FirebaseAuth.instance.currentUser!.uid.toString())) {
          isFav = docIsFav[FirebaseAuth.instance.currentUser!.uid.toString()];
        } else {
          isFav = false;
        }
        myRefusedCoursesList.add(CourseModel(
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
          favourite: isFav
        ));
      }
    });
    FirebaseFirestore.instance
        .collection('courses')
        .where('status', isEqualTo: 'waiting')
        .where('uidUser', isEqualTo: uId)
        .snapshots()
        .listen((event) {
      myWaitingCoursesList = [];
      for (var element in event.docs) {
        Map<String, dynamic> docIsFav = element['favourite'];
        bool isFav = false;
        if (docIsFav.containsKey(
            FirebaseAuth.instance.currentUser!.uid.toString())) {
          isFav = docIsFav[FirebaseAuth.instance.currentUser!.uid.toString()];
        } else {
          isFav = false;
        }
        myWaitingCoursesList.add(CourseModel(
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
          favourite: isFav
        ));
      }
    });

    // Get My Events

    FirebaseFirestore.instance
        .collection('events')
        .where('status', isEqualTo: 'accept')
        .where('uidUser', isEqualTo: uId)
        .snapshots()
        .listen((event) {
      myAcceptedEventsList = [];
      for (var element in event.docs) {
        Map<String, dynamic> docIsFav = element['favourite'];
        bool isFav = false;
        if (docIsFav.containsKey(
            FirebaseAuth.instance.currentUser!.uid.toString())) {
          isFav = docIsFav[FirebaseAuth.instance.currentUser!.uid.toString()];
        } else {
          isFav = false;
        }
        myAcceptedEventsList.add(EventModel(
          uid: element.id,
          image: element['image'],
          title: element['title'],
          location: element['location'],
          status: element['status'],
          date: element['date'],
          time: element['time'],
          uidUser: element['uidUser'],
          favourite: isFav
        ));
      }
    });
    FirebaseFirestore.instance
        .collection('events')
        .where('status', isEqualTo: 'refuse')
        .where('uidUser', isEqualTo: uId)
        .snapshots()
        .listen((event) {
      myRefusedEventsList = [];
      for (var element in event.docs) {
        Map<String, dynamic> docIsFav = element['favourite'];
        bool isFav = false;
        if (docIsFav.containsKey(
            FirebaseAuth.instance.currentUser!.uid.toString())) {
          isFav = docIsFav[FirebaseAuth.instance.currentUser!.uid.toString()];
        } else {
          isFav = false;
        }
        myRefusedEventsList.add(EventModel(
          uid: element.id,
          image: element['image'],
          title: element['title'],
          location: element['location'],
          status: element['status'],
          date: element['date'],
          time: element['time'],
          uidUser: element['uidUser'],
          favourite: isFav
        ));
      }
    });

    FirebaseFirestore.instance
        .collection('events')
        .where('status', isEqualTo: 'waiting')
        .where('uidUser', isEqualTo: uId)
        .snapshots()
        .listen((event) {
      myWaitingEventsList = [];
      for (var element in event.docs) {
        Map<String, dynamic> docIsFav = element['favourite'];
        bool isFav = false;
        if (docIsFav.containsKey(
            FirebaseAuth.instance.currentUser!.uid.toString())) {
          isFav = docIsFav[FirebaseAuth.instance.currentUser!.uid.toString()];
        } else {
          isFav = false;
        }
        myWaitingEventsList.add(EventModel(
          uid: element.id,
          image: element['image'],
          title: element['title'],
          location: element['location'],
          status: element['status'],
          date: element['date'],
          time: element['time'],
          uidUser: element['uidUser'],
          favourite: isFav
        ));
      }
    });
    emit(GetMyCoursesAndEventsSuccessState());
  }

  //   End function for  get my course and events

  getCertificates() {
    emit(GetCertificatesLoadingState());
    FirebaseFirestore.instance
        .collection('certificates')
        .where('uidSubscribe', isEqualTo: uId)
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


// Start of get Favorite
  getFavouriteCourse() async {
    emit(GetFavouriteCourseLoadingState());

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('courses')
        .get();
    favouriteCoursesList = [];
    for (var element in querySnapshot.docs) {
      Map<String, dynamic> docIsFav = element['favourite'];
      bool isFav = false;
      if (docIsFav.containsKey(
          uId)) {
        isFav = docIsFav[uId.toString()];
      } else {
        isFav = false;
      }
      print(isFav);
      print("=============================");

      if (docIsFav
          .containsKey(FirebaseAuth.instance.currentUser!.uid.toString()) && isFav == true) {

        favouriteCoursesList.add(CourseModel(
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
            favourite: isFav,
           ));
      }
    }
    emit(GetFavouriteCourseSuccessState());
  }

  getFavouriteEvent() async {
    emit(GetFavouriteEventsLoadingState());

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('events')
        .get();
    favouriteEventList = [];
    for (var element in querySnapshot.docs) {
      Map<String, dynamic> docIsFav = element['favourite'];
      bool isFav = false;
      if (docIsFav.containsKey(
          uId)) {
        isFav = docIsFav[uId.toString()];
      } else {
        isFav = false;
      }
      print(isFav);
      print("=============================");

      if (docIsFav
          .containsKey(FirebaseAuth.instance.currentUser!.uid.toString()) && isFav == true) {

        favouriteEventList.add(EventModel(
          uid: element.id,
          image: element['image'],
          title: element['title'],
          location: element['location'],
          status: element['status'],
          date: element['date'],
          time: element['time'],
          uidUser: element['uidUser'],
          numberAttendees: element['numberAttendees'],
          subscribers: element['subscribers'],
          favourite: isFav,
        ));
      }
    }
    emit(GetFavouriteEventsSuccessState());
  }

// End pf get Favorite


getEventVisitor(){
    emit(GetEventsVisitorLoadingState());
  FirebaseFirestore.instance
      .collection('events')
      .where('status', isEqualTo: 'accept')
      .snapshots()
      .listen((event) {
    eventsVisitorList = [];
    for (var element in event.docs) {

      Map<String, dynamic> docIsFav = element['favourite'];
      bool isFav = false;
      if (docIsFav.containsKey(
          FirebaseAuth.instance.currentUser!.uid.toString())) {
        isFav = docIsFav[FirebaseAuth.instance.currentUser!.uid.toString()];
      } else {
        isFav = false;
      }
      eventsVisitorList.add(EventModel(
          uid: element.id,
          image: element['image'],
          title: element['title'],
          location: element['location'],
          status: element['status'],
          date: element['date'],
          time: element['time'],
          uidUser: element['uidUser'],
          numberAttendees: element['numberAttendees'],
          subscribers: element['subscribers'],
          favourite: isFav));
      print(
        element['subscribers'],
      );
    }

    emit(GetEventsVisitorSuccessState());
  }).onError((error) {
    print(error.toString());
    emit(GetEventsVisitorErrorState(error.toString()));
  });
}


}
