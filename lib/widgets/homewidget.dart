import 'package:tinder_for_movies/utils/imports.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  late MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<String> _names = ["Red", "Blue", "Green", "Yellow", "Orange"];
  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange
  ];

  @override
  void initState() {
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _names[i], color: _colors[i]),
          likeAction: () {
            _scaffoldKey.currentState!.showSnackBar(SnackBar(
              content: Text("Liked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            _scaffoldKey.currentState!.showSnackBar(SnackBar(
              content: Text("Nope ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            _scaffoldKey.currentState!.showSnackBar(SnackBar(
              content: Text("Superliked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Minder")),
      body: Container(
          child: Column(children: [
        Container(
          height: 550,
          child: SwipeCards(
            matchEngine: _matchEngine,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: _swipeItems[index].content.color,
                child: Text(
                  _swipeItems[index].content.text,
                  style: TextStyle(fontSize: 100),
                ),
              );
            },
            onStackFinished: () {
              _scaffoldKey.currentState!.showSnackBar(SnackBar(
                content: Text("Stack Finished"),
                duration: Duration(milliseconds: 500),
              ));
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  _matchEngine.currentItem?.nope();
                },
                child: Text("Nope")),
            ElevatedButton(
                onPressed: () {
                  _matchEngine.currentItem?.superLike();
                },
                child: Text("Superlike")),
            ElevatedButton(
                onPressed: () {
                  _matchEngine.currentItem?.like();
                },
                child: Text("Like"))
          ],
        )
      ])),
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
