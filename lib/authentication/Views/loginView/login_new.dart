import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';
import 'package:m_soko/authentication/auth_exceptions.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/home/products/screens/mainScreen.dart';
import 'package:m_soko/main.dart';
import 'package:m_soko/models/user_model.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

void intializeCalling({
  required String userId,
  required String userName,
}) {
  /// 1.2.1. initialized ZegoUIKitPrebuiltCallInvitationService
  /// when app's user is logged in or re-logged in
  /// We recommend calling this method as soon as the user logs in to your app.
  try {
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: GlobalUtil.appIdForCalling /*input your AppID*/,
      appSign: GlobalUtil.appSignForCalling /*input your AppSign*/,
      userID: userId,
      userName: userName,
      plugins: [
        ZegoUIKitSignalingPlugin(),
      ],
    );
  } catch (e) {
    Logger().e(e.toString());
  }
}

Future<void> logInNew(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      UserDataService().fetchUserData(email).then((_) {
        // // Store user data locally after successful login
        UserDataService().storeUserDataLocally();
        intializeCalling(
            userId: email, userName: value.user!.displayName.toString());
      });

      // Navigate to the home screen
      Get.off(() => const MainScreen());
    });
  } on FirebaseAuthException catch (e) {
    Logger().e(e);
    if (e.code == 'user-not-found' || e.code == 'wrong-password') {
      throw InvalidCredentialsException();
    } else if (e.code == 'network-request-failed') {
      throw NetworkErrorException();
    } else {
      // Handle other FirebaseAuth exceptions here
    }
  }
}
