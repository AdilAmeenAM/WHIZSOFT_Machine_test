import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/model/user_model.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/service/auth_service.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/model/message_model.dart';

class ChatService {
  static CollectionReference<MessageModel> _messagesCollection(
          String chatRoomId) =>
      FirebaseFirestore.instance
          .collection('chat_room')
          .doc(chatRoomId)
          .collection('messages')
          .withConverter<MessageModel>(
              fromFirestore: MessageModel.fromFirestore,
              toFirestore: (value, options) => value.toFirestore());

  static Stream<List<UserModel>> getUsersStream() {
    return AuthService.userCollection
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // send messages
  static Future<void> sendMessage(String receiverID, String message) async {
    final String currentUserID = AuthService.getCurrentUser()!.uid;
    final DateTime time = DateTime.now();

    final newMessage = MessageModel(
        message: message,
        receiverID: receiverID,
        senderID: currentUserID,
        timestamp: time);

    /// Add the message to the chatroom
    await _messagesCollection(getChatRoomID(currentUserID, receiverID))
        .add(newMessage);
  }

  static Stream<List<MessageModel>> getMessages(
      String userID, String otherUserID) {
    return _messagesCollection(getChatRoomID(userID, otherUserID))
        .orderBy("timestamp", descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  static String getChatRoomID(String userID, String otherUserID) {
    List<String> ids = [userID, otherUserID];

    /// Sort the ids (this ensure the chatroomID is the same for any 2 people)
    ids.sort();

    String chatRoomID = ids.join("_");
    return chatRoomID;
  }
}
