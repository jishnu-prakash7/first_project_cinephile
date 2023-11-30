import 'dart:io';

import 'package:firstprojectcinephile/models/movie.dart';
import 'package:firstprojectcinephile/models/watchlist.dart';
import 'package:firstprojectcinephile/screens/movie/function.dart';
import 'package:firstprojectcinephile/screens/movie/home_screen.dart';
import 'package:firstprojectcinephile/widgets/admin_module_ref.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            )),
        body: ListView.builder(
            itemCount: userWatchlist.length,
            itemBuilder: (context, index) {
              final movielist = userWatchlist[index] as Watchlist;
              final movie = moviesBox.getAt(movielist.movieindex) as movies;
              return GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 235, 235, 235)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: const Color.fromARGB(
                                        255, 193, 193, 193)),
                                borderRadius: BorderRadius.circular(10)),
                            height: 120,
                            width: 160,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(movie.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 5,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: adminpanelDetailsText(
                                                '${movie.title}()',
                                                18,
                                                FontWeight.w700)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: adminpanelDetailsText(
                                            'Director :${movie.moviedirector}',
                                            15,
                                            FontWeight.w500)),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: adminpanelDetailsText(
                                      'Language :${movie.movielanguage}',
                                      15,
                                      FontWeight.w500)),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: ratingbar(movie.movierating)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      watchlistBox
                                          .deleteAt(index);
                                      setState(() {
                                        userWatchlist = watchlistBox.values
                                            .where((item) =>
                                                item.userindex == userindex)
                                            .toList();
                                      });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(
                                        Icons.delete,
                                        color: Color.fromARGB(255, 241, 81, 70),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
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
