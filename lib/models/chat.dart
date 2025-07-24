//Models
import '../models/chat_user.dart';
import '../models/chat_message.dart';

class Chat {
  final String id;
  final String currentUserId;
  final bool activity;
  final bool group;
  final List<ChatUser> members;
  List<ChatMessage> messages;

  late final List<ChatUser> _recepients;

  Chat({
    required this.id,
    required this.currentUserId,
    required this.members,
    required this.messages,
    required this.activity,
    required this.group,
  }) {
    _recepients = members.where((_i) => _i.uid != currentUserId).toList();
  }
  List<ChatUser> recepients() {
    return _recepients;
  }

  String title() {
    return !group
        ? _recepients.first.name
        : _recepients.map((_user) => _user.name).join(', ');
  }

  String imageUrl() {
    return !group
        ? _recepients.first.imageURL
        : 'https://tse3.mm.bing.net/th/id/OIP.5z8qXAjxVbJi84DTFXVyeQHaLH?r=0&rs=1&pid=ImgDetMain&o=7&rm=3';
  }
}
