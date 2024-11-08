import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class MessageModel with _$MessageModel {
  MessageModel._();

  factory MessageModel({
    required String senderID,
    required String receiverID,
    required String message,
    required DateTime timestamp,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  factory MessageModel.fromFirestore(
      DocumentSnapshot doc, SnapshotOptions? options) {
    final data = doc.data() as Map<String, dynamic>;
    return MessageModel.fromJson(data);
  }

  Map<String, dynamic> toFirestore() {
    return toJson();
  }
}
