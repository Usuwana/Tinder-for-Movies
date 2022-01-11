import 'package:tinder_for_movies/utils/imports.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}
