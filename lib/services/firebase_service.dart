import 'dart:io';
import 'package:path/path.dart' as P;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final String USER_COLLECTIONS = 'users';
final String POST_COLLECTIONS = "posts";

class FireBaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Map? currentUser;

  FireBaseService();

  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
    required File image,
  }) async {
    try {
      UserCredential _userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //1. create the user in firebase
      String _userId = _userCredential.user!.uid;
      //2. get the userId
      String _fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          P.extension(image.path);
      //3. create a filename for the file that we need to upload.
      // '23483753.jpg'
      UploadTask _task =
          _storage.ref('images/$_userId/$_fileName').putFile(image);
      // 4. Define a task for uploading the file and define the actual path in Firebase storage
      //    where we like to place the file .
      //'/images/2sds4242323ed2/245329f9dw.jpg'
      return _task.then((_snapshot) async {
        //it will start executing the task then it will going to call the function.
        String _downloadURL = await _snapshot.ref.getDownloadURL();
        // Once the task is complete, we get the actual download URL for the file
        await _db.collection(USER_COLLECTIONS).doc(_userId).set({
          "name": name,
          "email": email,
          "image": _downloadURL,
        });
        // and then to our Firebase Storage
        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (_userCredential.user != null) {
        currentUser = await getUserData(uid: _userCredential.user!.uid);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map> getUserData({required String uid}) async {
    DocumentSnapshot _doc =
        await _db.collection(USER_COLLECTIONS).doc(uid).get();
    return _doc.data() as Map;
  }

  Future<bool> postImage(File _image) async {
    try {
      String _userId = _auth.currentUser!.uid;
      String _fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          P.extension(_image.path);
      UploadTask _task =
          _storage.ref('images/$_userId/$_fileName').putFile(_image);
      //creates a task for uploading a file
      return await _task.then((_snapshot) async {
        //once the file is uploaded, we get its dowload url
        String _downloadURL = await _snapshot.ref.getDownloadURL();
        //adding this to the database
        await _db.collection(POST_COLLECTIONS).add({
          "userId": _userId,
          "timestamp": Timestamp.now(),
          "image": _downloadURL,
        });

        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<QuerySnapshot> getLatestPosts() {
    return _db
        .collection(POST_COLLECTIONS)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
