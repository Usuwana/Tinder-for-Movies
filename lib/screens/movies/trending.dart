import 'package:tinder_for_movies/presentation/flutter_app_icons.dart';
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
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: new TinderSwapCard(
                          swipeUp: false,
                          swipeDown: false,
                          stackNum: 3,
                          totalNum: api.trending.length,
                          swipeEdge: 4.0,
                          maxWidth: MediaQuery.of(context).size.width,
                          maxHeight: MediaQuery.of(context).size.height,
                          minWidth: MediaQuery.of(context).size.width * 0.9,
                          minHeight: MediaQuery.of(context).size.height * 0.9,
                          cardBuilder: (context, index) => Card(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Center(
                                  child: FadeInImage(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.9,
                                    fit: BoxFit.fill,
                                    placeholder:
                                        AssetImage("assets/company_logo.png"),
                                    image: api.trendingPosters[index],
                                  ),
                                ),
                                Positioned(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05,
                                  bottom: 0,
                                  child: Center(
                                    child: Container(
                                        alignment: Alignment.bottomCenter,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.8,
                                        child: SingleChildScrollView(
                                          child: Center(
                                            child: ReadMoreText(
                                              api.trendingOverviews[index],
                                              trimLines: 1,
                                              colorClickableText: Colors.pink,
                                              trimMode: TrimMode.Line,
                                              trimCollapsedText: '...Show more',
                                              trimExpandedText: ' show less',
                                              style: GoogleFonts.getFont(
                                                      'Montserrat')
                                                  .copyWith(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      backgroundColor: Colors
                                                          .blueGrey
                                                          .withOpacity(0.3)),
                                            ),
                                          ),
                                        )),
                                  ),
                                )
                              ],
                            ),
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
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ));

                                break;
                              case CardSwipeOrientation.RIGHT:
                                api.addLiked(
                                    api.trendingPostersLink[index],
                                    api.trendingTitles[index],
                                    api.trendingOverviews[index]);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ));
                                break;
                              case CardSwipeOrientation.RECOVER:
                                break;
                              default:
                                break;
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.red, width: 3),
                                  ),
                                  child: IconButton(
                                      color: Colors.red,
                                      iconSize: 50,
                                      onPressed: () {},
                                      icon: Icon(FlutterApp.dislike)),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.green, width: 3),
                                  ),
                                  child: IconButton(
                                      color: Colors.green,
                                      iconSize: 50,
                                      onPressed: () {},
                                      icon: Icon(FlutterApp.like)),
                                ),
                              )
                            ],
                          )),
                    )
                  ],
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
