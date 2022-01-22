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
  API api = new API();

  @override
  void initState() {
    //API api = new API();
    api.getLiked();

    print("BAZINGA" + api.likedTitles.length.toString());
    Future.delayed(const Duration(seconds: 20), () {
      setState(() {
        api.showLiked = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [Icon(MyFlutterApp.popular), Text("Liked Movies")],
          ),
        ),
        body: api.showLiked == false
            ? ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  //print(api.baseURL + api.popularPosters[index]);
                  return ProfileShimmer(
                    //isPurplishMode: true,
                    hasBottomLines: true,
                    //isDarkMode: true,
                  );
                })
            : ListView.builder(
                itemCount: api.likedTitles.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Image.network(
                              api.baseURL + api.likedPosters[index],
                            ),
                          ),
                          Column(
                            children: [
                              Text(api.likedTitles[index].toString()),
                              Text(api.likedOverviews[index].toString())
                            ],
                          )
                        ],
                      )
                    ],
                  );
                }),
      ),
    );
  }
}
