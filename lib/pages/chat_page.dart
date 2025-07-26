//Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Widgets
import '../widgets/top_bar.dart';
import '../widgets/custom_list_view_tiles.dart';

//Models
import '../models/chat.dart';
import '../models/chat_message.dart';
import '../widgets/custom_input_filed.dart';

//Providers
import '../providers/authentication_provider.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;
  ChatPage({required this.chat});
  @override
  State<StatefulWidget> createState() {
    return _ChatPageState();
  }
}

class _ChatPageState extends State<ChatPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;

  late GlobalKey<FormState> _messageFormState;
  late ScrollController _messagesListViewController;
  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold();
  }
}
