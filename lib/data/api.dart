import 'package:tinder_for_movies/utils/imports.dart';
import 'package:http/http.dart';
import 'dart:convert';

class API {
  bool showPlaying = false;
  late String playingTitle;
  late String playingOverview;
  late String playingBackdrop;
  List<String> playingBackdrops = [];
  List<String> playingTitles = [];
  List<String> playingOverviews = [];
  List<dynamic> nowPlaying = [];

  /*API(String playingTitle, String playingOverview, String playingBackdrop) {
    this.playingTitle = playingTitle;
    this.playingOverview = playingOverview;
    this.playingBackdrop = playingBackdrop;
  }*/

  Future<void> getNowPlaying() async {
    //make the request
    Response response = await get(
      'https://api.themoviedb.org/3/movie/now_playing?api_key=01654b20e22c2a6a6d22085d00bd3373',
    );
    Map data = jsonDecode(response.body);
    nowPlaying = data['results'];
    //print(allflights.length.toString() + "IS ALL OF IT");

    int i = 0;
    int j = 0;

    if (response.statusCode == 200) {
      while (i < data.length) {
        while (j < nowPlaying.length) {
          playingTitle = data['results'][j]['original_title'];
          playingOverview = data['results'][j]['overview'];
          playingBackdrop = data['results'][j]['backdrop_path'];
          playingTitles.add(playingTitle);
          playingOverviews.add(playingOverview);
          playingBackdrops.add(playingBackdrop);
          print(playingTitles);
          j++;
          i++;
        }
      }
    } else {
      throw new Exception("Could not get movies in play. Status code " +
          response.statusCode.toString());
    }
  }
}
