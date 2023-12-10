import 'package:firstprojectcinephile/models/comment.dart';
import 'package:firstprojectcinephile/models/movie.dart';
import 'package:firstprojectcinephile/models/user.dart';
import 'package:firstprojectcinephile/models/watchlist.dart';
import 'package:firstprojectcinephile/screens/movie/movie_details_screen/widgets.dart';
import 'package:firstprojectcinephile/screens/movie/function.dart';
import 'package:firstprojectcinephile/widgets/db_function.dart';
import 'package:firstprojectcinephile/widgets/home_and_details_ref.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DetailsScreen extends StatefulWidget {
  final movies movie;
  final int? movieindex;
  const DetailsScreen({Key? key, required this.movie, this.movieindex})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final commentController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  late Box commentBox;
  late Box userBox;
  late Box watchlistBox;
  int? userindex;
  late User? loggedInUser;
  late List comments = [];

  @override
  void initState() {
    super.initState();
    commentBox = Hive.box('comment');
    userBox = Hive.box('user');
    watchlistBox = Hive.box('watchlist');
    getUserIndex().then((value) {
      setState(() {
        userindex = value;
        comments = commentBox.values
            .where((comment) => comment.movieIndex == widget.movie.moviekey)
            .cast<Comment>()
            .toList();
      });
    });
  }

  void watchlistButtonClick() {
    int watchlistMovieIndex = -1;
    for (int i = 0; i < watchlistBox.length; i++) {
      final item = watchlistBox.getAt(i) as Watchlist;
      if (item.userindex == userindex && item.movieindex == widget.movieindex) {
        watchlistMovieIndex = i;
        break;
      }
    }

    setState(() {
      if (watchlistMovieIndex != -1) {
        deleteFromWatchlist(watchlistMovieIndex);
        watchlistSnackBar(context, Colors.red, 'Movie Removed from Watchlist');
      } else {
        addToWatchlist(
            Watchlist(userindex: userindex!, movieindex: widget.movieindex!));
        watchlistSnackBar(context, Colors.teal, 'Movie Added to Watchlist');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(85),
        child: Container(
          padding: const EdgeInsets.all(18),
          child: AppBar(
            primary: false,
            flexibleSpace: const Padding(padding: EdgeInsets.all(20)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(side: BorderSide(width: 2))),
                ),
                onPressed: () {
                  Navigator.of(context).pop('refresh');
                  setState(() {
                    watchlistBox = Hive.box('watchlist');
                  });
                },
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
            title: detailsScectionText('Details', 22, Colors.white),
            actions: [
              IconButton(
                  onPressed: () {
                    watchlistButtonClick();
                  },
                  icon: Icon(
                    watchlistBox.values.any((item) =>
                            item.userindex == userindex &&
                            item.movieindex == widget.movieindex)
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            movieDetails(
              movie: widget.movie,
              formkey: formkey,
              userindex: userindex,
              commentController: commentController,
            )
          ],
        ),
      ),
    ));
  }
}
