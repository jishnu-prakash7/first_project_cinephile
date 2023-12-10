import 'package:firstprojectcinephile/models/movie.dart';
import 'package:firstprojectcinephile/models/watchlist.dart';
import 'package:firstprojectcinephile/screens/movie/movie_details_screen/screen.dart';
import 'package:firstprojectcinephile/screens/movie/function.dart';
import 'package:firstprojectcinephile/screens/movie/home_screen/screen.dart';
import 'package:firstprojectcinephile/screens/movie/movie_watchlist_screen/widgets.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  late Box watchlistBox;
  late List userWatchlist;
  int? userindex;
  late Box moviesBox;

  @override
  void initState() {
    super.initState();
    userWatchlist = [];
    watchlistBox = Hive.box('watchlist');
    moviesBox = Hive.box('movies');
    getUserIndex().then((value) {
      setState(() {
        userindex = value;
        userWatchlist = watchlistBox.values
            .where((item) => item.userindex == userindex)
            .toList();
      });
    });
  }

  updateWatchlist() {
    setState(() {
      userWatchlist = watchlistBox.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: AppBar(
              title: appbarHeading('Watchlist', 22),
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return const HomeScreen();
                    }));
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color.fromARGB(255, 179, 178, 178),
                  )),
              backgroundColor: Colors.black,
            )),
        body: ValueListenableBuilder(
          valueListenable: watchlistBox.listenable(),
          builder: (context, value, child) => ListView.builder(
              itemCount: userWatchlist.length,
              itemBuilder: (context, index) {
                final movielist = userWatchlist[index] as Watchlist;
                final movie = moviesBox.getAt(movielist.movieindex) as movies;
                return GestureDetector(
                  onTap: () async {
                    String? refresh = await Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return DetailsScreen(movieindex: index, movie: movie);
                    }));

                    if (refresh == 'refresh') {
                      updateWatchlist();
                    }
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: WatchlistSection(
                      movie: movie,
                      index: index,
                      onWatchlistUpdated: (updatedWatchlist) {
                        setState(() {
                          userWatchlist = updatedWatchlist;
                        });
                      },
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
