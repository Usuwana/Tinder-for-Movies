import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:readmore/readmore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tinder_for_movies/presentation/my_flutter_app_icons.dart';
import 'package:tinder_for_movies/screens/SomethingWentWrong.dart';
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
        body: FutureBuilder(
            future: api.getLiked(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: api.likedTitles.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: ObjectKey(api.likedTitles[index]),
                        background: stackBehindDismiss(),
                        onDismissed: (direction) {
                          var item = api.likedTitles.elementAt(index);

                          api.removeLiked(api.likedTitles[index]);

                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Series deleted!"),
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
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 100,
                                              child: Image.network(
                                                api.baseURL +
                                                    api.likedPosters[index],
                                                fit: BoxFit.fill,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.blueGrey,
                                                      value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              loadingProgress
                                                                  .expectedTotalBytes!
                                                          : null,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Center(
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    child: Text(
                                                      api.likedTitles[index]
                                                          .toString(),
                                                      style:
                                                          GoogleFonts.getFont(
                                                                  'Montserrat')
                                                              .copyWith(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
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
                                                      style:
                                                          GoogleFonts.getFont(
                                                                  'Montserrat')
                                                              .copyWith(
                                                        fontSize: 11,
                                                        color: Colors.black,
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
                    });
              } else if (snapshot.hasError) {
                print('${snapshot.error}');
                return Center(child: SomethingWentWrong());
              }
              return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ProfileShimmer(
                      hasBottomLines: true,
                    );
                  });
            }),
      ),
    );
  }
}
