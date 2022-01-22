import 'package:tinder_for_movies/presentation/my_flutter_app_icons.dart';
import 'package:tinder_for_movies/utils/imports.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:readmore/readmore.dart';
import 'package:google_fonts/google_fonts.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({Key? key}) : super(key: key);

  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  API api = new API();

  @override
  void initState() {
    //API api = new API();
    api.getNowPlaying();
    Future.delayed(const Duration(seconds: 20), () {
      setState(() {
        api.showPlaying = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CardController controller;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          title: Column(
            children: [Icon(MyFlutterApp.playing), Text("Now Playing")],
          ),
        ),
        body: api.showPlaying == false
            ? ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  //print(api.baseURL + api.playingPosters[index]);
                  return ProfileShimmer(
                    //isPurplishMode: true,
                    hasBottomLines: true,
                    //isDarkMode: true,
                  );
                })
            : /*new Center(
              child: */
            Container(
                height: MediaQuery.of(context).size.height,
                //width: MediaQuery.of(context).size.width,
                child: new TinderSwapCard(
                  swipeUp: false,
                  swipeDown: false,
                  //orientation: AmassOrientation.BOTTOM,
                  totalNum: api.nowPlaying.length,
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
                            api.baseURL + api.playingPosters[index],
                            /*height: MediaQuery.of(context).size.height,*/
                          )),
                        ),
                        Positioned(
                          //bottom: 30,
                          child: Container(
                              child: Text(
                            api.playingTitles[index],
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
                                    api.playingOverviews[index],
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
                    /// Get orientation & index of swiped card!
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
                          /*margin: EdgeInsets.all(30.0),
                          behavior: SnackBarBehavior.fixed*/
                        ));

                        break;
                      case CardSwipeOrientation.RIGHT:
                        api.addLiked(
                            api.upcomingPosters[index],
                            api.upcomingTitles[index],
                            api.upcomingOverviews[index]);
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
              ));
    // ),
  }
}
