//Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

//Providers
import '../providers/authentication_provider.dart';
import '../providers/chats_page_provider.dart';

//Services
import '../services/navigation_service.dart';

//Pages
import '../pages/chat_page.dart';

//Widgets
import '../widgets/top_bar.dart';
import '../widgets/custom_list_view_tiles.dart';

//Models
import '../models/chat.dart';
import '../models/chat_user.dart';
import '../models/chat_message.dart';

class ChatsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatsPageState();
  }
}

class _ChatsPageState extends State<ChatsPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
  late ChatsPageProvider _pageProvider;
  late NavigationService _navigation;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    _navigation = GetIt.instance.get<NavigationService>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatsPageProvider>(
          create: (_) => ChatsPageProvider(_auth),
        ),
      ],
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(
      builder: (BuildContext _context) {
        _pageProvider = _context.watch<ChatsPageProvider>();
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.03,
            vertical: _deviceHeight * 0.02,
          ),
          height: _deviceHeight * 0.98,
          width: _deviceWidth * 0.97,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TopBar(
                'Chats',
                primaryAction: IconButton(
                  onPressed: () {
                    _auth.logout();
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Color.fromARGB(255, 28, 169, 145),
                  ),
                ),
              ),
              ///////////
              _ChatsList(),
            ],
          ),
        );
      },
    );
  }

  Widget _ChatsList() {
    List<Chat>? _chats = _pageProvider.chats;

    return Expanded(
      child: (() {
        if (_chats != null) {
          if (_chats.length != 0) {
            return ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (BuildContext _context, int _index) {
                return _ChatTile(_chats[_index]);
              },
            );
          } else {
            return Center(
              child: Text(
                'No chats found',
                style: TextStyle(color: Colors.black),
              ),
            );
          }
        } else {
          return Center(child: CircularProgressIndicator(color: Colors.black));
        }
      })(),
    );
  }

  Widget _ChatTile(Chat _chat) {
    List<ChatUser> _recepients = _chat.recepients();
    bool _isActive = _recepients.any((_d) => _d.wasRecentlyActive());
    String _subtitleText = '';
    if (_chat.messages.isNotEmpty) {
      _subtitleText = _chat.messages.first.type != MessageType.TEXT
          ? "Media Attachment"
          : _chat.messages.first.content;
    }
    return CustomListViewTilesWithActivity(
      height: _deviceHeight * 0.15,
      title: _chat.title(),
      subTitle: _subtitleText,
      imagePath: _chat.imageUrl(),
      isActive: _isActive,
      isActivity: _chat.activity,
      onTap: () {
        _navigation.navigateToPage(ChatPage(chat: _chat));
      },
    );
  }
}
