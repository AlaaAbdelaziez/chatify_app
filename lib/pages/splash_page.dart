//packages
import 'package:chatify_app/services/cloudinary_storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

//services
import '../services/navigation_service.dart';
import '../services/media_service.dart';
import '../services/cloud_storage_service.dart';
import '../services/database_service.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashPage({required Key key, required this.onInitializationComplete})
    : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1)).then((_) {
      _setup().then((_) => widget.onInitializationComplete());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatify',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      home: Scaffold(
        body: Center(
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/chat.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _setup() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    _registerServices();
  }

  void _registerServices() {
    GetIt.instance.registerSingleton<NavigationService>(NavigationService());
    GetIt.instance.registerSingleton<MediaService>(MediaService());
    GetIt.instance.registerSingleton<CloudStorageService>(
      CloudStorageService(),
    );
    GetIt.instance.registerSingleton<DatabaseService>(DatabaseService());
    GetIt.instance.registerSingleton<CloudinaryStorageService>(
      CloudinaryStorageService(),
    );
  }
}
