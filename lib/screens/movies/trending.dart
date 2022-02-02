import 'package:tinder_for_movies/presentation/my_flutter_app_icons.dart';
import 'package:tinder_for_movies/utils/imports.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:readmore/readmore.dart';
import 'package:google_fonts/google_fonts.dart';

class Trending extends StatefulWidget {
  const Trending({Key? key}) : super(key: key);

  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  APImovies api = new APImovies();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CardController controller;
    return Scaffold(
        body: FutureBuilder(
            future: api.getTrending(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: new TinderSwapCard(
                    swipeUp: false,
                    swipeDown: false,
                    totalNum: api.trending.length,
                    swipeEdge: 4.0,
                    maxWidth: MediaQuery.of(context).size.width * 1.9,
                    maxHeight: MediaQuery.of(context).size.width * 2.9,
                    minWidth: MediaQuery.of(context).size.width * 1.8,
                    minHeight: MediaQuery.of(context).size.width * 2.5,
                    cardBuilder: (context,
                            index) => /*SingleChildScrollView(
                      child:*/
                        Container(
                      height: MediaQuery.of(context).size.height,
                      child: Card(
                          child: Column(
                        children: [
                          /*SingleChildScrollView(
                              child: */
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                child: FadeInImage(
                                  fit: BoxFit.fill,
                                  placeholder:
                                      AssetImage("assets/company_logo.png"),
                                  image: api.trendingPosters[index],
                                ),
                              ),
                              Positioned(
                                child: Container(
                                    child: api.trendingTitles[index] != null
                                        ? Text(
                                            api.trendingTitles[index],
                                            style: GoogleFonts.getFont(
                                                    'Montserrat')
                                                .copyWith(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                          )
                                        : Text("")),
                              ),
                              Positioned(
                                left: 15,
                                bottom: 0,
                                child: Center(
                                  child: Container(
                                      alignment: Alignment.bottomCenter,
                                      width: 350,
                                      height: 200,
                                      child: SingleChildScrollView(
                                        child: ReadMoreText(
                                          api.trendingOverviews[index],
                                          trimLines: 3,
                                          colorClickableText: Colors.pink,
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: '...Show more',
                                          trimExpandedText: ' show less',
                                          style:
                                              GoogleFonts.getFont('Montserrat')
                                                  .copyWith(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      backgroundColor: Colors
                                                          .blueGrey
                                                          .withOpacity(0.1)),
                                        ),
                                      )),
                                ),
                              )
                            ],
                            //),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 10.0, top: 8.0),
                            child: Center(
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: ListTile(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        tileColor: Colors.red,
                                        title: Center(
                                          child: Text(
                                            'Swipe left to dislike',
                                            style: GoogleFonts.getFont(
                                                    'Montserrat')
                                                .copyWith(
                                              fontSize: 10,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: ListTile(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        tileColor: Colors.green,
                                        title: Center(
                                          child: Text(
                                            'Swipe right to like',
                                            style: GoogleFonts.getFont(
                                                    'Montserrat')
                                                .copyWith(
                                              fontSize: 10,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                      // ),
                    ),
                    cardController: controller = CardController(),
                    swipeUpdateCallback:
                        (DragUpdateDetails details, Alignment align) {
                      if (align.x < 0) {
                      } else if (align.x > 0) {}
                    },
                    swipeCompleteCallback:
                        (CardSwipeOrientation orientation, int index) {
                      switch (orientation) {
                        case CardSwipeOrientation.LEFT:
                          print("YESSIR");
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Center(
                              child: Text('DISLIKED!',
                                  style: GoogleFonts.getFont('Montserrat')
                                      .copyWith(
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red)),
                            ),
                            backgroundColor: Colors.transparent,
                            duration: Duration(milliseconds: 100),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ));

                          break;
                        case CardSwipeOrientation.RIGHT:
                          api.addLiked(
                              api.trendingPostersLink[index],
                              api.trendingTitles[index],
                              api.trendingOverviews[index]);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Center(
                              child: Text('LIKED!',
                                  style: GoogleFonts.getFont('Montserrat')
                                      .copyWith(
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                            ),
                            backgroundColor: Colors.transparent,
                            duration: Duration(milliseconds: 100),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ));
                          break;
                        case CardSwipeOrientation.RECOVER:
                          break;
                        default:
                          break;
                      }
                    },
                  ),
                );
              } else if (snapshot.hasError) {}
              return Center(
                child: Container(
                  child: LoadingAnimationWidget.inkDrop(
                      color: Colors.green, size: 100),
                ),
              );
            }));
  }
}
