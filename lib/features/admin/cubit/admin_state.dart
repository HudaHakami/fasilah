part of 'admin_cubit.dart';

@immutable
abstract class AdminState {}

class AdminInitial extends AdminState {}

class GetDataLoadingState extends AdminState {}

class GetDataSuccessState extends AdminState {

  GetDataSuccessState();
}

class GetDataErrorState extends AdminState {
  late final String error;

  GetDataErrorState(this.error);
}


class GetCourseLoadingState extends AdminState {}

class GetCourseSuccessState extends AdminState {

  GetCourseSuccessState();
}

class GetCourseErrorState extends AdminState {
  late final String error;

  GetCourseErrorState(this.error);
}

class GetEventsLoadingState extends AdminState {}

class GetEventsSuccessState extends AdminState {

  GetEventsSuccessState();
}

class GetEventsErrorState extends AdminState {
  late final String error;

  GetEventsErrorState(this.error);
}
class GetAcceptedEventsLoadingState extends AdminState {}

class GetAcceptedEventsSuccessState extends AdminState {

  GetAcceptedEventsSuccessState();
}

class GetAcceptedEventsErrorState extends AdminState {
  late final String error;

  GetAcceptedEventsErrorState(this.error);
}
class AcceptEventsLoadingState extends AdminState {}

class AcceptEventsSuccessState extends AdminState {

  AcceptEventsSuccessState();
}

class AcceptEventsErrorState extends AdminState {
  late final String error;

  AcceptEventsErrorState(this.error);
}
class RefuseEventsLoadingState extends AdminState {}

class RefuseEventsSuccessState extends AdminState {

  RefuseEventsSuccessState();
}

class RefuseEventsErrorState extends AdminState {
  late final String error;

  RefuseEventsErrorState(this.error);
}
class DeleteEventsLoadingState extends AdminState {}

class DeleteEventsSuccessState extends AdminState {

  DeleteEventsSuccessState();
}

class DeleteEventsErrorState extends AdminState {
  late final String error;

  DeleteEventsErrorState(this.error);
}
class StopEventsLoadingState extends AdminState {}

class StopEventsSuccessState extends AdminState {

  StopEventsSuccessState();
}

class StopEventsErrorState extends AdminState {
  late final String error;

  StopEventsErrorState(this.error);
}



class GetAcceptedCoursesLoadingState extends AdminState {}

class GetAcceptedCoursesSuccessState extends AdminState {

  GetAcceptedCoursesSuccessState();
}

class GetAcceptedCoursesErrorState extends AdminState {
  late final String error;

  GetAcceptedCoursesErrorState(this.error);
}
class AcceptCoursesLoadingState extends AdminState {}

class AcceptCoursesSuccessState extends AdminState {

  AcceptCoursesSuccessState();
}

class AcceptCoursesErrorState extends AdminState {
  late final String error;

  AcceptCoursesErrorState(this.error);
}
class RefuseCoursesLoadingState extends AdminState {}

class RefuseCoursesSuccessState extends AdminState {

  RefuseCoursesSuccessState();
}

class RefuseCoursesErrorState extends AdminState {
  late final String error;

  RefuseCoursesErrorState(this.error);
}
class DeleteCoursesLoadingState extends AdminState {}

class DeleteCoursesSuccessState extends AdminState {

  DeleteCoursesSuccessState();
}

class DeleteCoursesErrorState extends AdminState {
  late final String error;

  DeleteCoursesErrorState(this.error);
}
class StopCoursesLoadingState extends AdminState {}

class StopCoursesSuccessState extends AdminState {

  StopCoursesSuccessState();
}

class StopCoursesErrorState extends AdminState {
  late final String error;

  StopCoursesErrorState(this.error);
}

class EnrolledCoursesLoadingState extends AdminState {}

class EnrolledCoursesSuccessState extends AdminState {

  EnrolledCoursesSuccessState();
}

class EnrolledCoursesErrorState extends AdminState {
  late final String error;

  EnrolledCoursesErrorState(this.error);
}


class GetImageSuccessState extends AdminState {}

class GetImageErrorState extends AdminState {

  late final String error;

  GetImageErrorState(this.error);
}

class UploadCertificateImageSuccessState extends AdminState {}

class UploadCertificateImageLoadingState extends AdminState {}

class UploadCertificateImageErrorState extends AdminState {
  late final String error;

  UploadCertificateImageErrorState(this.error);
}

class UploadCertificateSuccessState extends AdminState {}

class UploadCertificateLoadingState extends AdminState {}

class UploadCertificateErrorState extends AdminState {
  late final String error;

  UploadCertificateErrorState(this.error);
}

class GetCertificatesLoadingState extends AdminState {

  GetCertificatesLoadingState();
}
class GetCertificatesSuccessState extends AdminState {

  GetCertificatesSuccessState();
}

class GetCertificatesErrorState extends AdminState {
  late final String error;

  GetCertificatesErrorState(this.error);
}



