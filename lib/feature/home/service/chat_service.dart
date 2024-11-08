import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/model/user_model.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/service/auth_service.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/model/message_model.dart';

class ChatService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Stream<List<UserModel>> getUsersStream() {
    return AuthService.userCollection
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // send messages
  static Future<void> sendMessage(String receiverID, String message) async {
    final String currentUserID = _auth.currentUser!.uid;
    final DateTime time = DateTime.now();

    final newMessage = MessageModel(
        message: message,
        receiverID: receiverID,
        senderID: currentUserID,
        timestamp: time);

    /// Add the message to the chatroom
    await _firestore
        .collection("chat_rooms")
        .doc(_getChatRoomID(currentUserID, receiverID))
        .collection("messages")
        .add(newMessage.toJson());
  }

  static Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    return _firestore
        .collection("chat_room")
        .doc(_getChatRoomID(userID, otherUserID))
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  static String _getChatRoomID(String userID, String otherUserID) {
    List<String> ids = [userID, otherUserID];

    /// Sort the ids (this ensure the chatroomID is the same for any 2 people)
    ids.sort();

    String chatRoomID = ids.join("_");
    return chatRoomID;
  }
}
