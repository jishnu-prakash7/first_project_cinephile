import 'dart:io';

import 'package:firstprojectcinephile/models/comment.dart';
import 'package:firstprojectcinephile/models/movie.dart';
import 'package:firstprojectcinephile/models/user.dart';
import 'package:firstprojectcinephile/models/watchlist.dart';
import 'package:firstprojectcinephile/screens/movie/function.dart';
import 'package:firstprojectcinephile/widgets/home_and_details_ref.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

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
  late List<Comment> comments = [];

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
            .where((comment) => comment.movieIndex == widget.movieindex)
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
        watchlistBox.deleteAt(watchlistMovieIndex);
        watchlistSnackBar(context, Colors.red, 'Movie Removed from Watchlist');
      } else {
        watchlistBox.add(
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
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
            title: Text(
              'Details',
              style: GoogleFonts.ubuntu(
                  textStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
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
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Image.file(
                  File(widget.movie.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  detailsScectionText(
                      '${widget.movie.title} (${DateFormat('yyyy').format(widget.movie.releaseyear)})',
                      20,
                      Colors.white),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        RatingAndGenereSection(
                          DateFormat('dd-MMM-yyyy')
                              .format(widget.movie.releaseyear),
                          Icons.calendar_today,
                          const Color.fromARGB(255, 234, 233, 233),
                        ),
                        verticaldivider(),
                        RatingAndGenereSection(
                          runtime(widget.movie.time),
                          FontAwesomeIcons.clock,
                          const Color.fromARGB(255, 234, 233, 233),
                        ),
                        verticaldivider(),
                        ratingbar(widget.movie.movierating),
                        verticaldivider(),
                        IconButton(
                            onPressed: () {
                              Share.share(
                                  'Hey check out this movie Review:${widget.movie.title}\n${widget.movie.review}');
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.shareFromSquare,
                              color: Colors.grey,
                            ))
                      ],
                    ),
                  ),
                  divider(),
                  detailsScectionText(
                      'Director : ${widget.movie.moviedirector}',
                      17,
                      const Color.fromARGB(255, 211, 210, 210)),
                  detailsScectionText(
                      'Language : ${widget.movie.movielanguage}',
                      17,
                      const Color.fromARGB(255, 211, 210, 210)),
                  detailsScectionText('Genere : ${widget.movie.moviegenre}', 17,
                      const Color.fromARGB(255, 211, 210, 210)),
                  divider(),
                  detailsScectionText('Review', 20, Colors.white),
                  commentSessionText(widget.movie.review,
                      const Color.fromARGB(255, 236, 234, 234), 15),
                  divider(),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: detailsScectionText('Comments', 20, Colors.white)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formkey,
                      child: TextFormField(
                        controller: commentController,
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Comment is needed !';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Add Comment . . .',
                            contentPadding: const EdgeInsets.only(left: 5),
                            hintStyle: GoogleFonts.ubuntu(
                                textStyle:
                                    const TextStyle(color: Colors.white)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 174, 243, 236))),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal)),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  addcomment(formkey, widget.movieindex,
                                      userindex, commentController);
                                  setState(() {
                                    comments = commentBox.values
                                        .where((comment) =>
                                            comment.movieIndex ==
                                            widget.movieindex)
                                        .cast<Comment>()
                                        .toList();
                                  });
                                },
                                icon: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ))),
                      ),
                    ),
                  ),
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        final uservalue =
                            userBox.getAt(comment.userIndex) as User;
                        return ListTile(
                            title: Container(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                      maxRadius: 15,
                                      backgroundImage: uservalue.image != null
                                          ? FileImage(File(uservalue.image!))
                                          : const AssetImage(
                                                  'assets/images/man.png')
                                              as ImageProvider),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      commentSessionText(
                                          uservalue.userName, Colors.white, 14),
                                      commentSessionText(
                                          DateFormat('dd-MMM-yyyy')
                                              .format(comment.date),
                                          Colors.grey,
                                          12)
                                    ],
                                  )
                                ],
                              ),
                            ),
                            subtitle: commentSessionText(
                                comment.comment, Colors.white, 15));
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
