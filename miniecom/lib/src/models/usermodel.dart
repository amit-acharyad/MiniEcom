import 'package:miniecom/src/models/productmodel.dart';

class User {
  final String? name;
  final String? email;
  final int? id;
  final String? password;

  // List<int> orders=[];
  User({this.name, this.email, this.id, this.password});
  User.fromDb(Map<String, dynamic> userData)
      : id = userData['id'],
        name = userData['name'],
        email = userData['email'],
        password = userData['password'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "email": email,
      "password": password,
    };
  }

  display() {
    print("Name:$name, Email:$email, Passsword: $password,id:$id");
  }
}
