import 'package:tinder_for_movies/presentation/my_flutter_app_icons.dart';
import 'package:tinder_for_movies/utils/imports.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:readmore/readmore.dart';
import 'package:google_fonts/google_fonts.dart';

class LikedMovies extends StatefulWidget {
  const LikedMovies({Key? key}) : super(key: key);

  @override
  _LikedMoviesState createState() => _LikedMoviesState();
}

class _LikedMoviesState extends State<LikedMovies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [Icon(MyFlutterApp.popular), Text("Liked Movies")],
        ),
      ),
    );
  }
}
