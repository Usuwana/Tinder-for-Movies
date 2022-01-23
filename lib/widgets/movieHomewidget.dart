import 'package:tinder_for_movies/utils/imports.dart';
import 'package:tinder_for_movies/presentation/my_flutter_app_icons.dart';
import 'package:tinder_for_movies/utils/imports.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:readmore/readmore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tinder_for_movies/widgets/movies/liked_movies.dart';
import 'package:tinder_for_movies/widgets/movies/trending.dart';
import 'package:tinder_for_movies/widgets/seriesHomewidget.dart';

class MovieHomeWidget extends StatefulWidget {
  const MovieHomeWidget({Key? key}) : super(key: key);

  @override
  _MovieHomeWidgetState createState() => _MovieHomeWidgetState();
}

class _MovieHomeWidgetState extends State<MovieHomeWidget> {
  //API api = new API();
  int _selectedIndex = 0;

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
    //API api = new API();
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
        appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: Center(
                child: Text("M--inder",
                    style: GoogleFonts.getFont('Montserrat')
                        .copyWith(fontSize: 32)))),
        body: _widgetOptions.elementAt(_selectedIndex),
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
            //backgroundColor: Colors.blueGrey,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            currentIndex: _selectedIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(MyFlutterApp.upcoming),
                label: 'Upcoming',
              ),
              BottomNavigationBarItem(
                icon: Icon(MyFlutterApp.trending),
                label: 'Trending',
              ),
              BottomNavigationBarItem(
                icon: Icon(MyFlutterApp.playing),
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
              BottomNavigationBarItem(
                icon: Icon(MyFlutterApp.like),
                label: 'Liked Movies',
              ),
            ],
          ),
        ));
  }
}
