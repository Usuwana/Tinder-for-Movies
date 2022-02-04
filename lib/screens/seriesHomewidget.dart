import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tinder_for_movies/screens/about.dart';
import 'package:tinder_for_movies/utils/imports.dart';
import 'package:url_launcher/url_launcher.dart';

class SeriesHomeWidget extends StatefulWidget {
  const SeriesHomeWidget({Key? key}) : super(key: key);

  @override
  _SeriesHomeWidgetState createState() => _SeriesHomeWidgetState();
}

class _SeriesHomeWidgetState extends State<SeriesHomeWidget> {
  int _selectedIndex = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<Widget> _widgetOptions = <Widget>[
    OnAir(),
    PopularSeries(),
    TopRatedSeries(),
    LikedSeries()
  ];
  String _linkedIn = 'https://my.linkedin.com/in/tatendausuwana';

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
              title: Text('About the app'),
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
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
            iconTheme: IconThemeData(color: Colors.blueGrey, size: 30),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Center(
                child: Text("S--inder",
                    style: GoogleFonts.getFont('Montserrat')
                        .copyWith(fontSize: 32, color: Colors.blueGrey)))),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blueGrey,
        key: _bottomNavigationKey,
        backgroundColor: Colors.white,
        items: <Widget>[
          Icon(MyFlutterApp.trending, size: 50),
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
