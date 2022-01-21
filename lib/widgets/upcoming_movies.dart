import 'package:tinder_for_movies/presentation/my_flutter_app_icons.dart';
import 'package:tinder_for_movies/utils/imports.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:readmore/readmore.dart';
import 'package:google_fonts/google_fonts.dart';

class UpcomingMovies extends StatefulWidget {
  const UpcomingMovies({Key? key}) : super(key: key);

  @override
  _UpcomingMoviesState createState() => _UpcomingMoviesState();
}

class _UpcomingMoviesState extends State<UpcomingMovies> {
  API api = new API();

  @override
  void initState() {
    //API api = new API();
    api.getUpcoming();
    Future.delayed(const Duration(seconds: 20), () {
      setState(() {
        api.showUpcoming = true;
      });
    });
    super.initState();
  }

  void handleSwipeCompleted(CardSwipeOrientation orientation, int index) {
    switch (orientation) {
      case CardSwipeOrientation.LEFT:
        print("YESSIR");

        ThemeData(
            snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.teal,
          actionTextColor: Colors.white,
          disabledActionTextColor: Colors.grey,
          contentTextStyle: TextStyle(fontSize: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          behavior: SnackBarBehavior.floating,
        ));
        break;
      case CardSwipeOrientation.RIGHT:
        break;
      case CardSwipeOrientation.RECOVER:
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    CardController controller;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: Column(
          children: [Icon(MyFlutterApp.upcoming), Text("Upcoming Movies")],
        ),
      ),
      body: api.showUpcoming == false
          ? ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                //print(api.baseURL + api.upcomingPosters[index]);
                return ProfileShimmer(
                  //isPurplishMode: true,
                  hasBottomLines: true,
                  //isDarkMode: true,
                );
              })
          : /*new Center(
              child: */
          /*SizedBox.expand(
                child: */
          Container(
              height: MediaQuery.of(context).size.height,
              //width: MediaQuery.of(context).size.width,
              child: new TinderSwapCard(
                swipeUp: false,
                swipeDown: false,
                //orientation: AmassOrientation.BOTTOM,
                totalNum: api.upcoming.length,
                //stackNum: 2,
                swipeEdge: 4.0,
                maxWidth: MediaQuery.of(context).size.width * 1.9,
                maxHeight: MediaQuery.of(context).size.width * 2.9,
                minWidth: MediaQuery.of(context).size.width * 1.8,
                minHeight: MediaQuery.of(context).size.width * 2.5,
                cardBuilder: (context, index) =>
                    /*Center(
                    child: */
                    Card(
                        //child: Image.network(api.baseURL + api.playingPosters[index]),
                        child: SingleChildScrollView(
                  child: Stack(
                    //overflow: Overflow.visible,
                    clipBehavior: Clip.none,
                    //alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        child: Container(
                            //height: 800,
                            child: Image.network(
                          api.baseURL + api.upcomingPosters[index],
                          /*height: MediaQuery.of(context).size.height,*/
                        )),
                      ),
                      Positioned(
                        //bottom: 30,
                        child: Container(
                            child: Text(
                          api.upcomingTitles[index],
                          style: GoogleFonts.getFont('Montserrat').copyWith(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                      ),
                      Positioned(
                        //top: 100,
                        left: 15,
                        bottom: 0,
                        child: Center(
                          child: Container(
                              alignment: Alignment.bottomCenter,
                              width: 350,
                              height: 200,
                              child:
                                  /*Text(
                                    api.playingOverviews[index],
                                    style: TextStyle(color: Colors.white),
                                    //maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                  )*/
                                  SingleChildScrollView(
                                child: ReadMoreText(
                                  api.upcomingOverviews[index],
                                  trimLines: 3,
                                  colorClickableText: Colors.pink,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: '...Show more',
                                  trimExpandedText: ' show less',
                                  style: GoogleFonts.getFont('Montserrat')
                                      .copyWith(
                                    fontSize: 15,
                                    color: Colors.white,
                                    /*backgroundColor: Colors.blueGrey*/
                                  ),
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                )
                        //print(api.baseURL + api.playingPosters[index])
                        ),
                // ),
                cardController: controller = CardController(),
                swipeUpdateCallback:
                    (DragUpdateDetails details, Alignment align) {
                  /// Get swiping card's alignment
                  if (align.x < 0) {
                    //Card is LEFT swiping
                  } else if (align.x > 0) {
                    //Card is RIGHT swiping
                  }
                },
                swipeCompleteCallback:
                    (CardSwipeOrientation orientation, int index) {
                  // handleSwipeCompleted(orientation, index);
                  switch (orientation) {
                    case CardSwipeOrientation.LEFT:
                      print("YESSIR");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Center(
                            child: Text('Disliked!',
                                style: GoogleFonts.getFont('Montserrat')
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red)),
                          ),
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          behavior: SnackBarBehavior.floating));
                      /*new ThemeData(
                          snackBarTheme: SnackBarThemeData(
                        backgroundColor: Colors.teal,
                        actionTextColor: Colors.white,
                        disabledActionTextColor: Colors.grey,
                        contentTextStyle: TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        behavior: SnackBarBehavior.floating,
                      ));*/
                      break;
                    case CardSwipeOrientation.RIGHT:
                      break;
                    case CardSwipeOrientation.RECOVER:
                      break;
                    default:
                      break;
                  }
                },
              ),
            ),
      //)
    );
  }
}
