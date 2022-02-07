import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:tinder_for_movies/screens/about.dart';
import 'package:tinder_for_movies/utils/imports.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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
  String _linkedIn = 'https://my.linkedin.com/in/tatendausuwana';
  String tmdb = "https://www.themoviedb.org/";

  @override
  void initState() {
    super.initState();
  }

  void _launchEmail() async {
    if (!await launch(
        'mailto:tatemapu@gmail.com?subject=This is Subject Title'))
      throw 'Could not launch mail';
  }

  void _launchURL() async {
    if (!await launch(_linkedIn)) throw 'Could not launch $_linkedIn';
  }

  void _launchTMDB() async {
    if (!await launch(tmdb)) throw 'Could not launch $tmdb';
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: true,
      childDecoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/app_logo.png',
                  ),
                ),
                ListTile(
                  title: Text('Movies'),
                  onTap: () {
                    Navigator.pushReplacement(
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => SeriesHomeWidget(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text('About Telly-Record'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => About(),
                      ),
                    );
                  },
                ),
                ListTile(title: Text('About the developer'), onTap: _launchURL),
                ListTile(title: Text('Send us feedback'), onTap: _launchEmail),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 90,
                        ),
                        Text('Powered by '),
                        IconButton(
                            onPressed: _launchTMDB,
                            icon: Image.asset(
                              "assets/tmdb.png",
                              scale: 5,
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
              leading: IconButton(
                color: Colors.blueGrey,
                iconSize: 30,
                onPressed: _handleMenuButtonPressed,
                icon: ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: _advancedDrawerController,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 250),
                      child: Icon(
                        value.visible ? Icons.clear : Icons.menu,
                        key: ValueKey<bool>(value.visible),
                      ),
                    );
                  },
                ),
              ),
              iconTheme: IconThemeData(color: Colors.blueGrey, size: 30),
              backgroundColor: Colors.transparent,
              elevation: 0,
              //backgroundColor: Colors.blueGrey,
              title: Center(
                child: Image.asset(
                  'assets/app_logo.png',
                  scale: 10,
                ),
              )),
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
      ),
    );
  }
}
