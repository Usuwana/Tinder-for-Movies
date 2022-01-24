import 'package:tinder_for_movies/data/liked.dart';
import 'package:tinder_for_movies/utils/imports.dart';
import 'package:http/http.dart';
import 'dart:convert';

class APIseries {
  bool showOnAir = false;
  bool showLatest = false;
  bool showPopular = false;
  bool showRated = false;
  bool showTrending = false;
  bool showLiked = false;
  late String onAirTitle;
  late String onAirOverview;
  late String onAirPoster;
  String baseURL = "https://image.tmdb.org/t/p/original/";
  List<NetworkImage> onAirPosters = [];
  List<String> onAirTitles = [];
  List<String> onAirOverviews = [];
  List<dynamic> onAir = [];
  late String popularTitle;
  late String popularOverview;
  late String popularPoster;
  List<NetworkImage> popularPosters = [];
  List<String> popularTitles = [];
  List<String> popularOverviews = [];
  List<dynamic> popular = [];

  late String ratedTitle;
  late String ratedOverview;
  late String ratedPoster;
  List<NetworkImage> ratedPosters = [];
  List<String> ratedTitles = [];
  List<String> ratedOverviews = [];
  List<dynamic> top_rated = [];

  List<dynamic> likedPosters = [];
  List<dynamic> likedTitles = [];
  List<dynamic> likedOverviews = [];
  List<dynamic> latest = [];
  //static List<Liked> liked = [];
  final firestoreInstance = FirebaseFirestore.instance;

  Future<void> addLiked(dynamic poster, String title, String overview) async {
    firestoreInstance.collection("likedSeries").add({
      "title": title,
      "overview": overview,
      "poster": poster,
    }).then((value) {
      print(value.id);
    });
  }

  void removeLiked(String title) {
    FirebaseFirestore.instance
        .collection("likedSeries")
        .where("title", isEqualTo: title)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("likedSeries")
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
        FirebaseFirestore.instance.collection("likedSeries");
    QuerySnapshot querySnapshot = await _collectionRef.get();

    likedTitles.addAll(querySnapshot.docs.map((doc) => doc["title"]).toList());
    likedOverviews
        .addAll(querySnapshot.docs.map((doc) => doc["overview"]).toList());
    likedPosters
        .addAll(querySnapshot.docs.map((doc) => doc["poster"]).toList());

    print(likedTitles);
  }

  Future<dynamic> getOnAir() async {
    Response response = await get(
      'https://api.themoviedb.org/3/tv/on_the_air?api_key=01654b20e22c2a6a6d22085d00bd3373',
    );
    Map data = jsonDecode(response.body);
    onAir = data['results'];

    int i = 0;
    int j = 0;

    if (response.statusCode == 200) {
      while (i < data.length) {
        while (j < onAir.length) {
          onAirTitle = data['results'][j]['name'];
          onAirOverview = data['results'][j]['overview'];
          onAirPoster = data['results'][j]['poster_path'];

          onAirTitles.add(onAirTitle);
          onAirOverviews.add(onAirOverview);
          onAirPosters.add(NetworkImage(baseURL + onAirPoster));

          j++;
          i++;
        }
      }
    } else {
      throw new Exception("Could not get movies in play. Status code " +
          response.statusCode.toString());
    }
    return onAirPosters;
  }

  Future<dynamic> getMostPopular() async {
    Response response = await get(
      'https://api.themoviedb.org/3/tv/popular?api_key=01654b20e22c2a6a6d22085d00bd3373',
    );
    Map data = jsonDecode(response.body);
    popular = data['results'];
    //print(allflights.length.toString() + "IS ALL OF IT");

    int i = 0;
    int j = 0;

    if (response.statusCode == 200) {
      while (i < data.length) {
        while (j < popular.length) {
          popularTitle = data['results'][j]['name'];
          popularOverview = data['results'][j]['overview'];
          popularPoster = data['results'][j]['poster_path'];
          popularTitles.add(popularTitle);
          popularOverviews.add(popularOverview);
          popularPosters.add(NetworkImage(baseURL + popularPoster));
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

  Future<dynamic> getTopRated() async {
    Response response = await get(
      'https://api.themoviedb.org/3/tv/top_rated?api_key=01654b20e22c2a6a6d22085d00bd3373',
    );
    Map data = jsonDecode(response.body);
    top_rated = data['results'];
    //print(allflights.length.toString() + "IS ALL OF IT");

    int i = 0;
    int j = 0;

    if (response.statusCode == 200) {
      while (i < data.length) {
        while (j < top_rated.length) {
          ratedTitle = data['results'][j]['name'];
          ratedOverview = data['results'][j]['overview'];
          ratedPoster = data['results'][j]['poster_path'];
          ratedTitles.add(ratedTitle);
          ratedOverviews.add(ratedOverview);
          ratedPosters.add(NetworkImage(baseURL + ratedPoster));

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
}
