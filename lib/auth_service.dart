import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Stream<User?> get userChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      throw e;
    }
  }

  Future<User?> registerWithEmailAndPassword(String email, String password,
      String username, File? profilePicture) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if (user != null) {
        String? profilePictureUrl;

        if (profilePicture != null) {
          profilePictureUrl =
              await _uploadProfilePicture(user.uid, profilePicture);
        }

        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'username': username,
          'profilePicture': profilePictureUrl,
        });

        await user.updatePhotoURL(profilePictureUrl);
        await user.updateDisplayName(username);
        await user.reload();
        user = _auth.currentUser;
      }

      return user;
    } catch (e) {
      throw e;
    }
  }

  Future<String> _uploadProfilePicture(String uid, File profilePicture) async {
    try {
      final ref = _storage.ref().child('profile_pictures').child('$uid.jpg');
      await ref.putFile(profilePicture);
      return await ref.getDownloadURL();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw e;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw e;
    }
  }
}
