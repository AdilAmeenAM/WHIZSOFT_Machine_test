import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whizsoft_chat_app_machine_test/core/utils/snackbar_utils.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/service/auth_service.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/model/message_model.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/service/chat_service.dart';

part 'chat_controller.g.dart';

@riverpod
class ChatController extends _$ChatController {
  @override
  void build() {}

  Future<void> sendMessage(String reciever, String message) async {
    try {
      await ChatService.sendMessage(reciever, message);
    } catch (e) {
      SnackBarUtils.showSnackbar('Cannot send message, Try again later');
    }
  }
}

@riverpod
Stream<List<MessageModel>> chatMessages(Ref ref, String recieverId) {
  final currentUserID = AuthService.getCurrentUser()!.uid;
  return ChatService.getMessages(currentUserID, recieverId);
}
