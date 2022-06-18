import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:restroapp/models/users.dart';

class SignIn {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> googleSignIn() async {
    var result = '';
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      User? currentuser = userCredential.user;
      if (currentuser != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          Users user = Users(
              mobile: '',
              name: currentuser.displayName!,
              email: currentuser.email!,
              id: currentuser.uid);

          await _firestore
              .collection('users')
              .doc(currentuser.uid)
              .set(user.tojson());
          //print('googleuser added');
        }
      }

      result = 'Success';
    } on FirebaseAuthException catch (e) {
      result = e.message.toString();
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<String> signInWithEmailPass(
      {required String email, required String pass}) async {
    var result = '';

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: pass);

      result = 'Success';
    } on FirebaseAuthException catch (e) {
      result = e.message.toString();
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<String> signUpUser(
      {required String email,
      required String pass,
      required String name,
      required String phone}) async {
    var result = '';

    try {
      if (email.isNotEmpty || pass.isNotEmpty || phone.isNotEmpty) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: pass);

        Users user = Users(
            mobile: phone, name: name, email: email, id: credential.user!.uid);

        _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.tojson());

        result = 'Success';
      }
    } on FirebaseAuthException catch (e) {
      result = e.message.toString();
    } catch (e) {
      result = e.toString();
    }
    return result;
  }
  //getuserdetails

  Future<Users> getUserDetails() async {
    User user = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(user.uid).get();

    return Users.fromSnap(snap);
  }

  void signOut() {
    _auth.signOut();
  }
}
