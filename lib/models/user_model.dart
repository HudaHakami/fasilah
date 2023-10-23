class UserModel {
  String? type;
  String? token;
  String? email;
  String? name;
  String? uid;



  UserModel({
    this.type,
    this.token,
    this.email,
    this.uid,
    this.name,



  });

  UserModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    token = json['token'];
    name = json['name'];
    email = json['email'];
    uid = json['uid'];


  }

  Map< String,dynamic > toMap(){
    return {
      'type' : type,
      'token' : token,
      'email': email,
      'name': name,
      'uid': uid,


    };
  }
}
