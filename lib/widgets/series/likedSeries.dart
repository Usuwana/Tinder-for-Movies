import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:readmore/readmore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tinder_for_movies/presentation/my_flutter_app_icons.dart';
import 'package:tinder_for_movies/utils/imports.dart';

class LikedSeries extends StatefulWidget {
  const LikedSeries({Key? key}) : super(key: key);

  @override
  _LikedSeriesState createState() => _LikedSeriesState();
}

class _LikedSeriesState extends State<LikedSeries> {
  APIseries api = new APIseries();

  @override
  void initState() {
    //API api = new API();
    api.getLiked();

    print("BAZINGA" + api.likedTitles.length.toString());
    Future.delayed(const Duration(seconds: 20), () {
      setState(() {
        api.showLiked = true;
      });
    });
    super.initState();
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: api.showLiked == false
            ? ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  //print(api.baseURL + api.popularPosters[index]);
                  return ProfileShimmer(
                    //isPurplishMode: true,
                    hasBottomLines: true,
                    //isDarkMode: true,
                  );
                })
            : ListView.builder(
                itemCount: api.likedTitles.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: ObjectKey(api.likedTitles[index]),
                    background: stackBehindDismiss(),
                    onDismissed: (direction) {
                      var item = api.likedTitles.elementAt(index);
                      //To delete
                      //deleteItem(index);
                      api.removeLiked(api.likedTitles[index]);
                      //To show a snackbar with the UNDO button
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Movie deleted!"),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Row(
                                      //direction: Axis.horizontal,
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 100,
                                          child: Image.network(
                                            api.baseURL +
                                                api.likedPosters[index],
                                          ),
                                        ),
                                        Column(
                                          //direction: Axis.vertical,
                                          children: [
                                            Center(
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                child: Text(
                                                  api.likedTitles[index]
                                                      .toString(),
                                                  style: GoogleFonts.getFont(
                                                          'Montserrat')
                                                      .copyWith(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: ReadMoreText(
                                                  api.likedOverviews[index]
                                                      .toString(),
                                                  trimLines: 5,
                                                  colorClickableText:
                                                      Colors.pink,
                                                  trimMode: TrimMode.Line,
                                                  trimCollapsedText:
                                                      '...Show more',
                                                  trimExpandedText:
                                                      ' show less',
                                                  style: GoogleFonts.getFont(
                                                          'Montserrat')
                                                      .copyWith(
                                                    fontSize: 11,
                                                    color: Colors.black,
                                                    /*backgroundColor: Colors.blueGrey*/
                                                  )),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}