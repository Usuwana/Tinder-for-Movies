import 'package:flutter/services.dart';
import 'package:tinder_for_movies/utils/imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      home: MovieHomeWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}
