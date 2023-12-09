

import 'dart:io';

import 'package:firstprojectcinephile/models/movie.dart';
import 'package:firstprojectcinephile/screens/movie/function.dart';
import 'package:firstprojectcinephile/widgets/admin_module_ref.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

typedef WatchlistUpdatedCallback = void Function(List);

class WatchlistSection extends StatefulWidget {
  final WatchlistUpdatedCallback onWatchlistUpdated;
  final movies movie;
  final int index;
  const WatchlistSection(
      {super.key,
      required this.movie,
      required this.index,
      required this.onWatchlistUpdated});

  @override
  State<WatchlistSection> createState() => _watchlistSectionState();
}

class _watchlistSectionState extends State<WatchlistSection> {
  late Box watchlistBox;
  late List userWatchlist;
  int? userindex;
  @override
  void initState() {
    watchlistBox = Hive.box('watchlist');
    super.initState();
    userWatchlist = [];
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
    return Container(
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
                      color: const Color.fromARGB(255, 193, 193, 193)),
                  borderRadius: BorderRadius.circular(10)),
              height: 120,
              width: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(widget.movie.imageUrl),
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
                                  '${widget.movie.title}(${DateFormat('yyyy').format(widget.movie.releaseyear)})',
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
                              'Director :${widget.movie.moviedirector}',
                              15,
                              FontWeight.w500)),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: adminpanelDetailsText(
                        'Language :${widget.movie.movielanguage}',
                        15,
                        FontWeight.w500)),
                Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: ratingbar(widget.movie.movierating)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        watchlistBox.deleteAt(widget.index);
                        setState(() {
                          userWatchlist = watchlistBox.values
                              .where((item) => item.userindex == userindex)
                              .toList();
                        });

                        widget.onWatchlistUpdated(userWatchlist);
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
    );
  }
}
