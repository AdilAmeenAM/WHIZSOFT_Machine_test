import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/model/message.dart';

class ChatService {
  // get instance of firestore

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //  get user stream

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // go through each individual user
        final user = doc.data();
        // return user
        return user;
      }).toList();
    });
  }

  // send messages
  Future<void> sendMessage(String receiverID, String message) async {
    // get current user info

    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new message

    Message newMessage = Message(
        message: message,
        receiverID: receiverID,
        senderEmail: currentUserID,
        senderID: currentUserEmail,
        timestamp: timestamp);

    // construct chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];

    ids.sort(); //sort the ids (this ensure the chatroomID is the same for any 2 people)
    String chatRoomID = ids.join("_");
    // add new message to the database

    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMAp());
  }

  // get messages

  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    // construct a chatroom ID for the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join("_");
    return _firestore
        .collection("chat_room")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
