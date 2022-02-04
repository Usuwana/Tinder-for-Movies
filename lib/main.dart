import 'package:flutter/services.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:theme_mode_builder/theme_mode_builder.dart';
import 'package:tinder_for_movies/utils/imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeModeBuilderConfig.ensureInitialized(
    subDir: "Theme Mode Builder Example",
  );
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

    return ThemeModeBuilder(
        builder: (BuildContext context, ThemeMode themeMode) {
      return MaterialApp(
        home: SplashScreenView(
          navigateRoute: MovieHomeWidget(),
          duration: 3000,
          imageSize: 200,
          imageSrc: "assets/logo.png",
          backgroundColor: Colors.black,
          pageRouteTransition: PageRouteTransition.CupertinoPageRoute,
        ),
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
