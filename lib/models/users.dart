import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String name, mobile, email, id;

  Users(
      {required this.mobile,
      required this.name,
      required this.email,
      required this.id});

  Map<String, dynamic> tojson() => {
        'name': name,
        'uid': id,
        'email': email,
        'mobile': mobile,
      };
  static Users fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    // print('idddd----->${snapshot['uid']}');
    return Users(
      mobile: snapshot['mobile'],
      name: snapshot['name'],
      email: snapshot['email'],
      id: snapshot['uid'],
    );
  }
}
