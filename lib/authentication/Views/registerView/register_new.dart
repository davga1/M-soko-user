import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';
import 'package:m_soko/authentication/auth_exceptions.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/routes/app_routes.dart';

Future<void> createUser(String name, String email, String password) async {
  if (name.isEmpty || email.isEmpty || password.isEmpty) {
    throw EmptyFieldException('All fields');
  }
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) async {
      await FirebaseFirestore.instance
          .collection(FirestoreCollections.usersCollection)
          .doc(value.user!.email)
          .set({
        'uid': value.user!.uid,
        'userName': name,
        'email': value.user!.email,
      });
      FirebaseAuth.instance
          .signOut()
          .then((value) => Get.offAllNamed(AppRoutes.loginScreen));
      Fluttertoast.showToast(
          msg: 'Account Created', toastLength: Toast.LENGTH_SHORT);
    });
  } on FirebaseAuthException catch (e) {
    Logger().e(e);
    if (e.code == 'weak-password') {
      throw WeakPasswordException();
    } else if (e.code == 'email-already-in-use') {
      ();
      throw EmailAlreadyInUseException();
    } else if (e.code == 'invalid-email') {
      ();
      throw InvalidEmailException();
    } else {
      ();
      throw AuthException();
    }
  }
}
