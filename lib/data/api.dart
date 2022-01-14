import 'package:tinder_for_movies/utils/imports.dart';
import 'package:http/http.dart';
import 'dart:convert';

class API {
  bool showPlaying = false;
  bool showUpcoming = false;
  bool showPopular = false;
  bool showRated = false;
  bool showTrending = false;
  late String playingTitle;
  late String playingOverview;
  late String playingPoster;
  String baseURL = "https://image.tmdb.org/t/p/original/";
  List<String> playingPosters = [];
  List<String> playingTitles = [];
  List<String> playingOverviews = [];
  List<dynamic> nowPlaying = [];
  late String popularTitle;
  late String popularOverview;
  late String popularPoster;
  List<String> popularPosters = [];
  List<String> popularTitles = [];
  List<String> popularOverviews = [];
  List<dynamic> popular = [];
  late String upcomingTitle;
  late String upcomingOverview;
  late String upcomingPoster;
  List<String> upcomingPosters = [];
  List<String> upcomingTitles = [];
  List<String> upcomingOverviews = [];
  List<dynamic> upcoming = [];
  late String ratedTitle;
  late String ratedOverview;
  late String ratedPoster;
  List<String> ratedPosters = [];
  List<String> ratedTitles = [];
  List<String> ratedOverviews = [];
  List<dynamic> top_rated = [];
  late String trendingTitle;
  late String trendingOverview;
  late String trendingPoster;
  List<String> trendingPosters = [];
  List<String> trendingTitles = [];
  List<String> trendingOverviews = [];
  List<dynamic> trending = [];

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
          playingPoster = data['results'][j]['poster_path'];
          playingTitles.add(playingTitle);
          playingOverviews.add(playingOverview);
          playingPosters.add(playingPoster);
          //print(playingTitles);
          j++;
          i++;
        }
      }
    } else {
      throw new Exception("Could not get movies in play. Status code " +
          response.statusCode.toString());
    }
  }

  Future<void> getMostPopular() async {
    Response response = await get(
      'https://api.themoviedb.org/3/movie/popular?api_key=01654b20e22c2a6a6d22085d00bd3373',
    );
    Map data = jsonDecode(response.body);
    popular = data['results'];
    //print(allflights.length.toString() + "IS ALL OF IT");

    int i = 0;
    int j = 0;

    if (response.statusCode == 200) {
      while (i < data.length) {
        while (j < popular.length) {
          popularTitle = data['results'][j]['title'];
          popularOverview = data['results'][j]['overview'];
          popularPoster = data['results'][j]['poster_path'];
          popularTitles.add(popularTitle);
          popularOverviews.add(popularOverview);
          popularPosters.add(popularPoster);
          //print(playingTitles);
          j++;
          i++;
        }
      }
    } else {
      throw new Exception("Could not get movies in play. Status code " +
          response.statusCode.toString());
    }
  }

  Future<void> getUpcoming() async {
    Response response = await get(
      'https://api.themoviedb.org/3/movie/upcoming?api_key=01654b20e22c2a6a6d22085d00bd3373',
    );
    Map data = jsonDecode(response.body);
    upcoming = data['results'];
    //print(allflights.length.toString() + "IS ALL OF IT");

    int i = 0;
    int j = 0;

    if (response.statusCode == 200) {
      while (i < data.length) {
        while (j < upcoming.length) {
          upcomingTitle = data['results'][j]['original_title'];
          upcomingOverview = data['results'][j]['overview'];
          upcomingPoster = data['results'][j]['poster_path'];
          upcomingTitles.add(upcomingTitle);
          upcomingOverviews.add(upcomingOverview);
          upcomingPosters.add(upcomingPoster);
          //print(playingTitles);
          j++;
          i++;
        }
      }
    } else {
      throw new Exception("Could not get movies in play. Status code " +
          response.statusCode.toString());
    }
  }

  Future<void> getTopRated() async {
    Response response = await get(
      'https://api.themoviedb.org/3/movie/top_rated?api_key=01654b20e22c2a6a6d22085d00bd3373',
    );
    Map data = jsonDecode(response.body);
    top_rated = data['results'];
    //print(allflights.length.toString() + "IS ALL OF IT");

    int i = 0;
    int j = 0;

    if (response.statusCode == 200) {
      while (i < data.length) {
        while (j < top_rated.length) {
          ratedTitle = data['results'][j]['original_title'];
          ratedOverview = data['results'][j]['overview'];
          ratedPoster = data['results'][j]['poster_path'];
          ratedTitles.add(ratedTitle);
          ratedOverviews.add(ratedOverview);
          ratedPosters.add(ratedPoster);
          //print(playingTitles);
          j++;
          i++;
        }
      }
    } else {
      throw new Exception("Could not get movies in play. Status code " +
          response.statusCode.toString());
    }
  }

  Future<void> getTrending() async {
    Response response = await get(
      'https://api.themoviedb.org/3/trending/all/day?api_key=01654b20e22c2a6a6d22085d00bd3373',
    );
    Map data = jsonDecode(response.body);
    trending = data['results'];
    //print(allflights.length.toString() + "IS ALL OF IT");

    int i = 0;
    int j = 0;

    if (response.statusCode == 200) {
      while (i < data.length) {
        while (j < top_rated.length) {
          trendingTitle = data['results'][j]['title'];
          trendingOverview = data['results'][j]['overview'];
          trendingPoster = data['results'][j]['poster_path'];
          trendingTitles.add(trendingTitle);
          trendingOverviews.add(trendingOverview);
          trendingPosters.add(trendingPoster);
          //print(playingTitles);
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
