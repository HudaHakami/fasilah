part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class GetDataLoadingState extends UserState {}

class GetDataSuccessState extends UserState {

  GetDataSuccessState();
}

class GetDataErrorState extends UserState {
  late final String error;

  GetDataErrorState(this.error);
}
class UpdateProfileLoadingState extends UserState {}

class UpdateProfileSuccessState extends UserState {

  UpdateProfileSuccessState();
}

class UpdateProfileErrorState extends UserState {
  late final String error;

  UpdateProfileErrorState(this.error);
}


class ChangeBottomNavState extends UserState {}



class AddCourseLoadingState extends UserState {}

class AddCourseSuccessState extends UserState {

  AddCourseSuccessState();
}

class AddCourseErrorState extends UserState {
  late final String error;

  AddCourseErrorState(this.error);
}
class AddEventLoadingState extends UserState {}

class AddEventSuccessState extends UserState {

  AddEventSuccessState();
}

class AddEventErrorState extends UserState {
  late final String error;

  AddEventErrorState(this.error);
}


class GetImageSuccessState extends UserState {}

class GetImageErrorState extends UserState {

  late final String error;

  GetImageErrorState(this.error);
}

class UploadCourseImageSuccessState extends UserState {}

class UploadCourseImageLoadingState extends UserState {}

class UploadCourseImageErrorState extends UserState {
  late final String error;

  UploadCourseImageErrorState(this.error);
}



class SubscribeCourseLoadingState extends UserState {}

class SubscribeCourseSuccessState extends UserState {

  SubscribeCourseSuccessState();
}

class SubscribeCourseErrorState extends UserState {
  late final String error;

  SubscribeCourseErrorState(this.error);
}
class SubscribeEventLoadingState extends UserState {}

class SubscribeEventSuccessState extends UserState {

  SubscribeEventSuccessState();
}

class SubscribeEventErrorState extends UserState {
  late final String error;

  SubscribeEventErrorState(this.error);
}


class GetCoursesAndEventsLoadingState extends UserState {}

class GetCoursesAndEventsSuccessState extends UserState {

  GetCoursesAndEventsSuccessState();
}

class GetCoursesAndEventsErrorState extends UserState {
  late final String error;

  GetCoursesAndEventsErrorState(this.error);
}
class GetMyCoursesAndEventsSuccessState extends UserState {

  GetMyCoursesAndEventsSuccessState();
}

class GetMyCoursesAndEventsErrorState extends UserState {
  late final String error;

  GetMyCoursesAndEventsErrorState(this.error);
}
class GetCoursesAndEventsSubscribeLoadingState extends UserState {}

class GetCoursesAndEventsSubscribeSuccessState extends UserState {

  GetCoursesAndEventsSubscribeSuccessState();
}

class GetCoursesAndEventsSubscribeErrorState extends UserState {
  late final String error;

  GetCoursesAndEventsSubscribeErrorState(this.error);
}


class GetCertificatesLoadingState extends UserState {

  GetCertificatesLoadingState();
}
class GetCertificatesSuccessState extends UserState {

  GetCertificatesSuccessState();
}

class GetCertificatesErrorState extends UserState {
  late final String error;

  GetCertificatesErrorState(this.error);
}

class FavouriteCourseVisibilityState extends UserState {


  FavouriteCourseVisibilityState();
}

class FavouriteEventVisibilityState extends UserState {


  FavouriteEventVisibilityState();
}

class GetFavouriteCourseLoadingState extends UserState {

  GetFavouriteCourseLoadingState();
}
class GetFavouriteCourseSuccessState extends UserState {

  GetFavouriteCourseSuccessState();
}

class GetFavouriteCourseErrorState extends UserState {
  late final String error;

  GetFavouriteCourseErrorState(this.error);
}
class GetFavouriteEventsLoadingState extends UserState {

  GetFavouriteEventsLoadingState();
}
class GetFavouriteEventsSuccessState extends UserState {

  GetFavouriteEventsSuccessState();
}

class GetFavouriteEventsErrorState extends UserState {
  late final String error;

  GetFavouriteEventsErrorState(this.error);
}

class GetEventsVisitorLoadingState extends UserState {

  GetEventsVisitorLoadingState();
}
class GetEventsVisitorSuccessState extends UserState {

  GetEventsVisitorSuccessState();
}

class GetEventsVisitorErrorState extends UserState {
  late final String error;

  GetEventsVisitorErrorState(this.error);
}