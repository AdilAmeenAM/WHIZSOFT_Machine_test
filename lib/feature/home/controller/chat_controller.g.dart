// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatMessagesHash() => r'777da1873bc3ef0367d4fd5e1e231a0edbd097d7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [chatMessages].
@ProviderFor(chatMessages)
const chatMessagesProvider = ChatMessagesFamily();

/// See also [chatMessages].
class ChatMessagesFamily extends Family<AsyncValue<List<MessageModel>>> {
  /// See also [chatMessages].
  const ChatMessagesFamily();

  /// See also [chatMessages].
  ChatMessagesProvider call(
    String recieverId,
  ) {
    return ChatMessagesProvider(
      recieverId,
    );
  }

  @override
  ChatMessagesProvider getProviderOverride(
    covariant ChatMessagesProvider provider,
  ) {
    return call(
      provider.recieverId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'chatMessagesProvider';
}

/// See also [chatMessages].
class ChatMessagesProvider
    extends AutoDisposeStreamProvider<List<MessageModel>> {
  /// See also [chatMessages].
  ChatMessagesProvider(
    String recieverId,
  ) : this._internal(
          (ref) => chatMessages(
            ref as ChatMessagesRef,
            recieverId,
          ),
          from: chatMessagesProvider,
          name: r'chatMessagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatMessagesHash,
          dependencies: ChatMessagesFamily._dependencies,
          allTransitiveDependencies:
              ChatMessagesFamily._allTransitiveDependencies,
          recieverId: recieverId,
        );

  ChatMessagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.recieverId,
  }) : super.internal();

  final String recieverId;

  @override
  Override overrideWith(
    Stream<List<MessageModel>> Function(ChatMessagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChatMessagesProvider._internal(
        (ref) => create(ref as ChatMessagesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        recieverId: recieverId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<MessageModel>> createElement() {
    return _ChatMessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatMessagesProvider && other.recieverId == recieverId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, recieverId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChatMessagesRef on AutoDisposeStreamProviderRef<List<MessageModel>> {
  /// The parameter `recieverId` of this provider.
  String get recieverId;
}

class _ChatMessagesProviderElement
    extends AutoDisposeStreamProviderElement<List<MessageModel>>
    with ChatMessagesRef {
  _ChatMessagesProviderElement(super.provider);

  @override
  String get recieverId => (origin as ChatMessagesProvider).recieverId;
}

String _$chatControllerHash() => r'9b403c6636413fdad93ad4d5b8bd79adb89d3cb0';

/// See also [ChatController].
@ProviderFor(ChatController)
final chatControllerProvider =
    AutoDisposeNotifierProvider<ChatController, void>.internal(
  ChatController.new,
  name: r'chatControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChatController = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
