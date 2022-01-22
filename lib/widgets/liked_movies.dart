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
                  return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      child: Image.network(
                                        api.baseURL + api.likedPosters[index],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          api.likedTitles[index].toString(),
                                          style:
                                              GoogleFonts.getFont('Montserrat')
                                                  .copyWith(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: ReadMoreText(
                                              api.likedOverviews[index]
                                                  .toString(),
                                              trimLines: 5,
                                              colorClickableText: Colors.pink,
                                              trimMode: TrimMode.Line,
                                              trimCollapsedText: '...Show more',
                                              trimExpandedText: ' show less',
                                              style: GoogleFonts.getFont(
                                                      'Montserrat')
                                                  .copyWith(
                                                fontSize: 11,
                                                color: Colors.black,
                                                /*backgroundColor: Colors.blueGrey*/
                                              )),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
      ),
    );
  }
}
