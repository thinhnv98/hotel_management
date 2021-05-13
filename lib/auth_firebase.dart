import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthFirebase {
  AuthFirebase._privateConstructor();

  static final AuthFirebase _instance = AuthFirebase._privateConstructor();

  static AuthFirebase get instance => _instance;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future<User> signIn(String email, String passWord, Function onSuccess,
      Function(String) onErrorMessage) async {
    var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: passWord);
    if (userCredential != null) {
      var user = userCredential.user;
      var idToken = await user.getIdToken();
      print("Token: " + idToken);
      return user;
    }
    return null;
  }

  Future signOut() async {
    // await _googleSignIn.signOut();
    // await facebookSignIn.logOut();

    await _firebaseAuth.signOut();
  }

  Future<User> signUp(String email, String passWord, Function onSuccess,
      Function(String) onErrorMessage) async {
    var user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: passWord);
    try {
      _createUser(user.user.uid, email, () async {
        onSuccess();
        //await user.user.sendEmailVerification();
      }, onErrorMessage);
    } catch (e) {
      print("An error occured while trying to send email verification");
      print(e.toString());
      return null;
    }
    return user.user;
  }

  Future _createUser(String userId, String email, Function onSuccess,
      Function(String) onErrorMessage) async {
    var user = {"email": email, "uuid": userId};
    var userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    userRef.set(user).catchError((error) async {
      await onErrorMessage("Sign up fail, Please try again.");
    });
  }

  Future sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
