import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:message_practice/login_screen/screen/login_screen.dart';

// class LoginController extends GetxController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   late final GoogleSignIn _googleSignIn;

//   // Observable variables
//   Rx<User?> firebaseUser = Rx<User?>(null);
//   RxBool isLoading = false.obs;
//   RxBool isInitialized = false.obs;

//   @override
//   void onInit() async {
//     super.onInit();

//     // Get the GoogleSignIn singleton instance
//     _googleSignIn = GoogleSignIn.instance;

//     // Initialize GoogleSignIn (REQUIRED in v7+)
//     await _googleSignIn.initialize();
//     isInitialized.value = true;

//     // Bind firebase user to observable
//     firebaseUser.bindStream(_auth.authStateChanges());

//     // Listen to Google Sign-In authentication events
//     _googleSignIn.authenticationEvents.listen((event) {
//       if (event is GoogleSignInAuthenticationEventSignIn) {
//         debugPrint('User signed in: ${event.user.displayName}');
//       } else if (event is GoogleSignInAuthenticationEventSignOut) {
//         debugPrint('User signed out');
//       }
//     });
//   }

//   // Google Sign-In Function
//   Future<void> signInWithGoogle() async {
//     try {
//       if (!isInitialized.value) {
//         debugPrint('Google Sign-In not initialized yet');
//         // Get.snackbar(
//         //   'Error',
//         //   'Google Sign-In not initialized yet',
//         //   snackPosition: SnackPosition.BOTTOM,
//         // );
//         return;
//       }

//       isLoading.value = true;

//       // Trigger the authentication flow (v7+ uses authenticate())
//       final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

//       // Obtain the auth details from the request (now synchronous in v7+)
//       final GoogleSignInAuthentication googleAuth = googleUser.authentication;

//       // Get authorization for Firebase
//       final authClient = _googleSignIn.authorizationClient;
//       final authorization = await authClient.authorizationForScopes(['email']);

//       // Create a new credential
//       final credential = GoogleAuthProvider.credential(
//         accessToken: authorization?.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       // Sign in to Firebase with the Google credential
//       final UserCredential userCredential =
//           await _auth.signInWithCredential(credential);

//       isLoading.value = false;
//       debugPrint("User signed in: ${userCredential.user?.displayName}");
//       Get.snackbar(
//         'Success',
//         'Welcome ${userCredential.user?.displayName ?? "User"}!',
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       // Navigate to home screen after successful login
//       // Get.offAllNamed('/home'); // Uncomment and use your route

//     } on GoogleSignInException catch (e) {
//       isLoading.value = false;
//       // Check if user cancelled using code.name
//       if (e.code.name == 'canceled') {
//         debugPrint('Google Sign-In cancelled');
//         Get.snackbar(
//           'Cancelled',
//           'Sign-in was cancelled',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       } else {
//         debugPrint('Google Sign-In failed: ${e.description}');
//         Get.snackbar(
//           'Error',
//           e.description ?? 'Google Sign-In failed',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       isLoading.value = false;
//       debugPrint('Firebase Authentication failed: ${e.message}');
//       Get.snackbar(
//         'Error',
//         e.message ?? 'Authentication failed',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } catch (e) {
//       isLoading.value = false;
//       debugPrint('Something went wrong: $e');
//       Get.snackbar(
//         'Error',
//         'Something went wrong: $e',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   // Sign Out Function
//   Future<void> signOut() async {
//     try {
//       await _googleSignIn.signOut();
//       await _auth.signOut();
//       debugPrint('Signed out successfully');
//       Get.snackbar(
//         'Signed Out',
//         'You have been signed out successfully',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       // Get.offAllNamed('/login'); // Uncomment and use your route
//     } catch (e) {
//       debugPrint('Sign out failed: $e');
//       Get.snackbar(
//         'Error',
//         'Sign out failed: $e',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   // Get Current User
//   User? get currentUser => _auth.currentUser;
// }

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final GoogleSignIn _googleSignIn;

  // Observable variables
  Rx<User?> firebaseUser = Rx<User?>(null);
  RxBool isLoading = false.obs;
  RxBool isInitialized = false.obs;

  @override
  void onInit() async {
    super.onInit();

    // Get the GoogleSignIn singleton instance with serverClientId
    _googleSignIn = GoogleSignIn.instance;

    // Initialize GoogleSignIn with serverClientId (REQUIRED for Android)
    await _googleSignIn.initialize(
      serverClientId:
          '117895636744-139me16ou529cbt6o6do4atvp0u29tca.apps.googleusercontent.com',
      //scopes: ['email'],
    );
    isInitialized.value = true;

    // Bind firebase user to observable
    firebaseUser.bindStream(_auth.authStateChanges());

    // Listen to Google Sign-In authentication events
    _googleSignIn.authenticationEvents.listen((event) {
      if (event is GoogleSignInAuthenticationEventSignIn) {
        debugPrint('User signed in: ${event.user.displayName}');
      } else if (event is GoogleSignInAuthenticationEventSignOut) {
        debugPrint('User signed out');
      }
    });
  }

  // Google Sign-In Function
  Future<void> signInWithGoogle() async {
    try {
      if (!isInitialized.value) {
        debugPrint('Google Sign-In not initialized yet');
        Get.snackbar(
          'Error',
          'Google Sign-In not initialized yet',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      isLoading.value = true;

      // Trigger the authentication flow (v7+ uses authenticate())
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      // Obtain the auth details from the request (now synchronous in v7+)
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // Get authorization for Firebase
      final authClient = _googleSignIn.authorizationClient;
      final authorization = await authClient.authorizationForScopes(['email']);

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: authorization?.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      isLoading.value = false;
      debugPrint('User signed in: ${userCredential.user?.displayName}');
      Get.snackbar(
        'Success',
        'Welcome ${userCredential.user?.displayName ?? "User"}!',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.to(() => HomeScreen());
      // Navigate to home screen after successful login
      // Get.offAllNamed('/home'); // Uncomment and use your route
    } on GoogleSignInException catch (e) {
      isLoading.value = false;
      // Check if user cancelled using code.name
      if (e.code.name == 'canceled') {
        debugPrint('Sign-in was cancelled');
        Get.snackbar(
          'Cancelled',
          'Sign-in was cancelled',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        debugPrint('Google Sign-In failed: ${e.description}');
        Get.snackbar(
          'Error',
          e.description ?? 'Google Sign-In failed',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      debugPrint('Authentication failed: ${e.message}');
      Get.snackbar(
        'Error',
        e.message ?? 'Authentication failed',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      isLoading.value = false;
      debugPrint('Something went wrong: $e');
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Sign Out Function
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      debugPrint('Signed out successfully');
      Get.snackbar(
        'Signed Out',
        'You have been signed out successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      // Get.offAllNamed('/login'); // Uncomment and use your route
    } catch (e) {
      debugPrint('Sign out failed: $e');
      Get.snackbar(
        'Error',
        'Sign out failed: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Get Current User
  User? get currentUser => _auth.currentUser;
}
