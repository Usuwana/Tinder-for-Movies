import 'package:tinder_for_movies/utils/imports.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  List<String> welcomeImages = [
    "assets/welcome0.png",
    "assets/welcome1.png",
    "assets/welcome2.png",
    "assets/welcome2.png",
    "assets/welcome1.png",
    "assets/welcome1.png"
  ];
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
      appBar: AppBar(title: Text("Minder")),
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
              height: MediaQuery.of(context).size.height * 0.6,
              child: new TinderSwapCard(
                //swipeUp: true,
                //swipeDown: true,
                orientation: AmassOrientation.BOTTOM,
                totalNum: api.nowPlaying.length,
                stackNum: 3,
                swipeEdge: 4.0,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
                maxHeight: MediaQuery.of(context).size.width * 0.9,
                minWidth: MediaQuery.of(context).size.width * 0.8,
                minHeight: MediaQuery.of(context).size.width * 0.8,
                cardBuilder: (context, index) => Card(
                  child: Image.network(api.baseURL + api.playingPosters[index]),
                  //print(api.baseURL + api.playingPosters[index])
                ),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Upcoming',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Now Playing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Popular',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Top Rated',
          ),
        ],
      ),
    );
  }
}
