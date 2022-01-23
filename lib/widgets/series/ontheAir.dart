import 'package:tinder_for_movies/presentation/my_flutter_app_icons.dart';
import 'package:tinder_for_movies/utils/imports.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:readmore/readmore.dart';
import 'package:google_fonts/google_fonts.dart';

class OnAir extends StatefulWidget {
  const OnAir({Key? key}) : super(key: key);

  @override
  _OnAirState createState() => _OnAirState();
}

class _OnAirState extends State<OnAir> {
  APIseries api = new APIseries();

  @override
  void initState() {
    api.getOnAir();
    Future.delayed(const Duration(seconds: 20), () {
      setState(() {
        api.showOnAir = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CardController controller;
    return Scaffold(
      body: api.showOnAir == false
          ? Center(
              child: Container(
                child: LoadingAnimationWidget.inkDrop(
                    color: Colors.grey, size: 100),
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              //width: MediaQuery.of(context).size.width,
              child: new TinderSwapCard(
                swipeUp: false,
                swipeDown: false,
                //orientation: AmassOrientation.BOTTOM,
                totalNum: api.onAir.length,
                //stackNum: 2,
                swipeEdge: 4.0,
                maxWidth: MediaQuery.of(context).size.width * 1.9,
                maxHeight: MediaQuery.of(context).size.width * 2.9,
                minWidth: MediaQuery.of(context).size.width * 1.8,
                minHeight: MediaQuery.of(context).size.width * 2.5,
                cardBuilder: (context, index) => Card(
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
                          api.baseURL + api.onAirPosters[index],
                          /*height: MediaQuery.of(context).size.height,*/
                        )),
                      ),
                      Positioned(
                        //bottom: 30,
                        child: Container(
                            child: Text(
                          api.onAirTitles[index],
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
                              child: SingleChildScrollView(
                                child: ReadMoreText(
                                  api.onAirOverviews[index],
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
                      api.getLiked();
                      //print(api.getLiked().toString());
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Center(
                          child: Text('DISLIKED!',
                              style: GoogleFonts.getFont('Montserrat').copyWith(
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
                      api.addLiked(api.onAirPosters[index],
                          api.onAirTitles[index], api.onAirOverviews[index]);
                      print(api.onAirTitles[index]);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Center(
                          child: Text('LIKED!',
                              style: GoogleFonts.getFont('Montserrat').copyWith(
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
            ),
      //)
    );
  }
}