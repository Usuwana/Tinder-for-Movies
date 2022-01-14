import 'package:tinder_for_movies/presentation/my_flutter_app_icons.dart';
import 'package:tinder_for_movies/utils/imports.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:readmore/readmore.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
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
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                onTap: () {},
                title: Text('Upcoming'),
              ),
              ListTile(
                onTap: () {},
                title: Text('Now Playing'),
              ),
              ListTile(
                onTap: () {},
                title: Text('Popular'),
              ),
              ListTile(
                onTap: () {},
                title: Text('Top Rated'),
              ),
            ],
          ),
        ),
        appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: Center(
                child: Text("M--inder",
                    style: GoogleFonts.getFont('Montserrat')
                        .copyWith(fontSize: 32)))),
        body: api.showPlaying == false
            ? ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  print(api.baseURL + api.playingPosters[index]);
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
                  },
                ),
              ),
        // ),
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.blueGrey,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: Colors.red,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: Colors.white))),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(MyFlutterApp.upcoming),
                label: 'Upcoming',
              ),
              BottomNavigationBarItem(
                icon: Icon(MyFlutterApp.now),
                label: 'Now Playing',
              ),
              BottomNavigationBarItem(
                icon: Icon(MyFlutterApp.popular),
                label: 'Popular',
              ),
              BottomNavigationBarItem(
                icon: Icon(MyFlutterApp.rated),
                label: 'Top Rated',
              ),
            ],
          ),
        ));
  }
}
