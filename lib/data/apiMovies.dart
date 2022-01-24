import 'package:tinder_for_movies/data/liked.dart';
import 'package:tinder_for_movies/utils/imports.dart';
import 'package:http/http.dart';
import 'dart:convert';

class APImovies {
  bool showPlaying = false;
  bool showUpcoming = false;
  bool showPopular = false;
  bool showRated = false;
  bool showTrending = false;
  bool showLiked = false;
  late String playingTitle;
  late String playingOverview;
  late String playingPoster;
  String baseURL = "https://image.tmdb.org/t/p/original/";
  List<NetworkImage> playingPosters = [];
  List<String> playingPostersLink = [];
  List<String> playingTitles = [];
  List<String> playingOverviews = [];
  List<dynamic> nowPlaying = [];
  late String popularTitle;
  late String popularOverview;
  late String popularPoster;
  List<NetworkImage> popularPosters = [];
  List<String> popularPostersLink = [];
  List<String> popularTitles = [];
  List<String> popularOverviews = [];
  List<dynamic> popular = [];
  late String upcomingTitle;
  late String upcomingOverview;
  late String upcomingPoster;
  List<NetworkImage> upcomingPosters = [];
  List<String> upcomingPostersLink = [];
  List<String> upcomingTitles = [];
  List<String> upcomingOverviews = [];
  List<dynamic> upcoming = [];
  late String ratedTitle;
  late String ratedOverview;
  late String ratedPoster;
  List<NetworkImage> ratedPosters = [];
  List<String> ratedPostersLink = [];
  List<String> ratedTitles = [];
  List<String> ratedOverviews = [];
  List<dynamic> top_rated = [];
  late String trendingTitle;
  late String trendingOverview;
  late String trendingPoster;
  List<NetworkImage> trendingPosters = [];
  List<String> trendingPostersLink = [];
  List<String> trendingTitles = [];
  List<String> trendingOverviews = [];
  List<dynamic> likedPosters = [];
  List<dynamic> likedTitles = [];
  List<dynamic> likedOverviews = [];
  List<dynamic> trending = [];
  //static List<Liked> liked = [];
  final firestoreInstance = FirebaseFirestore.instance;

  Future<void> addLiked(String poster, String title, String overview) async {
    //Liked like = new Liked(poster, title, overview);
    //liked.add(like);
    //await Firebase.initializeApp();
    firestoreInstance.collection("likedMovies").add({
      "title": title,
      "overview": overview,
      "poster": poster,
    }).then((value) {
      print(value.id);
    });
  }

  void removeLiked(String title) {
    //liked.remove(like);
    //var myRef = firestoreInstance.collection("likes").document(userId!!);
    FirebaseFirestore.instance
        .collection("likedMovies")
        .where("title", isEqualTo: title)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("likedMovies")
            .doc(element.id)
            .delete()
            .then((value) {
          print("Success!");
        });
      });
    });
  }

  Future<void> getLiked() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("likedMovies");
    QuerySnapshot querySnapshot = await _collectionRef.get();
    //likedTitles = querySnapshot.docs.map((doc) => doc["title"]).toList();
    //likedOverviews = querySnapshot.docs.map((doc) => doc["overview"]).toList();
    //likedPosters = querySnapshot.docs.map((doc) => doc["poster"]).toList();
    likedTitles.addAll(querySnapshot.docs.map((doc) => doc["title"]).toList());
    likedOverviews
        .addAll(querySnapshot.docs.map((doc) => doc["overview"]).toList());
    likedPosters
        .addAll(querySnapshot.docs.map((doc) => doc["poster"]).toList());
    // Get data from docs and convert map to List
    //final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(likedTitles);
    // return liked;
  }

  Future<dynamic> getNowPlaying() async {
    // likedTitles.clear();
    //likedPosters.clear();
    //likedOverviews.clear();
    //getLiked(); //make the request
    Response response = await get(
      'https://api.themoviedb.org/3/movie/now_playing?api_key=01654b20e22c2a6a6d22085d00bd3373',
    );
    Map data = jsonDecode(response.body);
    nowPlaying = data['results'];

    int i = 0;
    int j = 0;

    if (response.statusCode == 200) {
      while (i < data.length) {
        while (j < nowPlaying.length) {
          playingTitle = data['results'][j]['original_title'];
          playingOverview = data['results'][j]['overview'];
          playingPoster = data['results'][j]['poster_path'];

          // for (var i = 0; i < likedTitles.length; i++) {
          //  if (!(likedTitles[i].toString() == playingTitle) &&
          //    !(likedOverviews[i].toString() == playingOverview)) {
          playingTitles.add(playingTitle);
          playingOverviews.add(playingOverview);
          playingPosters.add(NetworkImage(baseURL + playingPoster));
          playingPostersLink.add(playingPoster);
          //   }
          // }

          //print(playingTitles);
          j++;
          i++;
        }
      }
    } else {
      throw new Exception("Could not get movies in play. Status code " +
          response.statusCode.toString());
    }
    return playingPosters;
  }

  Future<dynamic> getMostPopular() async {
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
          popularPosters.add(NetworkImage(baseURL + popularPoster));
          popularPostersLink.add(popularPoster);
          //print(playingTitles);
          j++;
          i++;
        }
      }
    } else {
      throw new Exception("Could not get movies in play. Status code " +
          response.statusCode.toString());
    }
    return popularPosters;
  }

  Future<dynamic> getUpcoming() async {
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
          upcomingPosters.add(NetworkImage(baseURL + upcomingPoster));
          upcomingPostersLink.add(upcomingPoster);
          //print(playingTitles);
          j++;
          i++;
        }
      }
    } else {
      throw new Exception("Could not get movies in play. Status code " +
          response.statusCode.toString());
    }
    //return jsonDecode(response.body);
    return upcomingPosters;
  }

  Future<dynamic> getTopRated() async {
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
          ratedPosters.add(NetworkImage(baseURL + ratedPoster));
          ratedPostersLink.add(ratedPoster);
          //print(playingTitles);
          j++;
          i++;
        }
      }
    } else {
      throw new Exception("Could not get movies in play. Status code " +
          response.statusCode.toString());
    }
    return ratedPosters;
  }

  Future<dynamic> getTrending() async {
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
        while (j < trending.length) {
          trendingTitle = data['results'][j]['title'];
          trendingOverview = data['results'][j]['overview'];
          trendingPoster = data['results'][j]['poster_path'];
          trendingTitles.add(trendingTitle);
          trendingOverviews.add(trendingOverview);
          trendingPosters.add(NetworkImage(baseURL + trendingPoster));
          trendingPostersLink.add(trendingPoster);
          //print(playingTitles);
          print(trendingTitles);
          j++;
          i++;
        }
      }
    } else {
      throw new Exception("Could not get movies in play. Status code " +
          response.statusCode.toString());
    }
    return trendingPosters;
  }
}
