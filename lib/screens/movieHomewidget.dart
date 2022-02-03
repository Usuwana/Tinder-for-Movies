import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tinder_for_movies/utils/imports.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieHomeWidget extends StatefulWidget {
  const MovieHomeWidget({Key? key}) : super(key: key);

  @override
  _MovieHomeWidgetState createState() => _MovieHomeWidgetState();
}

class _MovieHomeWidgetState extends State<MovieHomeWidget> {
  int _selectedIndex = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<Widget> _widgetOptions = <Widget>[
    UpcomingMovies(),
    Trending(),
    NowPlaying(),
    MostPopular(),
    TopRated(),
    LikedMovies()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(''),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
            ),
            ListTile(
              title: Text('Movies'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => MovieHomeWidget(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Series'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SeriesHomeWidget(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
            iconTheme: IconThemeData(color: Colors.blueGrey, size: 30),
            backgroundColor: Colors.transparent,
            elevation: 0,
            //backgroundColor: Colors.blueGrey,
            title: Center(
                child: Text("M--inder",
                    style: GoogleFonts.getFont('Montserrat')
                        .copyWith(fontSize: 32, color: Colors.blueGrey)))),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blueGrey,
        key: _bottomNavigationKey,
        backgroundColor: Colors.white,
        items: <Widget>[
          Icon(MyFlutterApp.upcoming, size: 50),
          Icon(MyFlutterApp.trending, size: 50),
          Icon(MyFlutterApp.playing, size: 50),
          Icon(MyFlutterApp.popular, size: 50),
          Icon(MyFlutterApp.rated, size: 50),
          Icon(MyFlutterApp.like, size: 50)
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
