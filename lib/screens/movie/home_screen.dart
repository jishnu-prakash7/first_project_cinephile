import 'dart:io';
import 'package:firstprojectcinephile/screens/movie/details_screen.dart';
import 'package:firstprojectcinephile/screens/movie/drawer.dart';
import 'package:firstprojectcinephile/screens/movie/function.dart';
import 'package:firstprojectcinephile/widgets/home_and_details_ref.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  List<dynamic> searchMovie = [];
  late Box moviesBox;
  String selectedCatagory = '';

  @override
  void initState() {
    super.initState();
    moviesBox = Hive.box('movies');
    searchMovie = List.from(moviesBox.values);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              title: maintitle(),
              centerTitle: true,
              iconTheme: const IconThemeData(
                  color: Color.fromARGB(255, 233, 230, 230)),
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 350,
                      height: 45,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            search();
                          });
                        },
                        controller: searchController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(30)),
                            contentPadding: const EdgeInsets.all(0),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 41, 41, 41)),
                                borderRadius: BorderRadius.circular(30)),
                            fillColor: const Color.fromARGB(255, 41, 41, 41),
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Color.fromARGB(255, 209, 207, 207),
                            ),
                            hintText: 'Search Movies',
                            hintStyle: GoogleFonts.ubuntu(
                                textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 223, 222, 222))),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                  )),
            ),
            drawer: const Mydrawer(),
            body:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    catagoriesButton('Allmovies', () {
                      setState(() {
                        selectedCatagory = '';
                        search();
                        // search(
                        //     searchController: searchController,
                        //     searchMovie: searchMovie,
                        //     moviesBox: moviesBox,
                        //     selectedCatagory: selectedCatagory);
                      });
                    }),
                    catagoriesButton('Action', () {
                      setState(() {
                        selectedCatagory = 'Action';
                        search();
                        // search(
                        //     searchController: searchController,
                        //     searchMovie: searchMovie,
                        //     moviesBox: moviesBox,
                        //     selectedCatagory: selectedCatagory);
                      });
                    }),
                    catagoriesButton('Comedy', () {
                      setState(() {
                        selectedCatagory = 'Comedy';
                        search();
                        // search(
                        //     searchController: searchController,
                        //     searchMovie: searchMovie,
                        //     moviesBox: moviesBox,
                        //     selectedCatagory: selectedCatagory);
                      });
                    }),
                    catagoriesButton('Horror', () {
                      setState(() {
                        selectedCatagory = 'Horror';
                        search();
                        // search(
                        //     searchController: searchController,
                        //     searchMovie: searchMovie,
                        //     moviesBox: moviesBox,
                        //     selectedCatagory: selectedCatagory);
                      });
                    }),
                    catagoriesButton('English', () {
                      setState(() {
                        selectedCatagory = 'English';
                        search();
                        // search(
                        //     searchController: searchController,
                        //     searchMovie: searchMovie,
                        //     moviesBox: moviesBox,
                        //     selectedCatagory: selectedCatagory);
                      });
                    }),
                    catagoriesButton('Hindi', () {
                      setState(() {
                        selectedCatagory = 'hindi';
                        search();
                        // search(
                        //     searchController: searchController,
                        //     searchMovie: searchMovie,
                        //     moviesBox: moviesBox,
                        //     selectedCatagory: selectedCatagory);
                      });
                    }),
                    catagoriesButton('Malayalam', () {
                      setState(() {
                        selectedCatagory = 'Malayalam';
                        search();
                        // search(
                        //     searchController: searchController,
                        //     searchMovie: searchMovie,
                        //     moviesBox: moviesBox,
                        //     selectedCatagory: selectedCatagory);
                      });
                    }),
                    catagoriesButton('Tamil', () {
                      setState(() {
                        selectedCatagory = 'Tamil';
                        search();
                        // search(
                        //     searchController: searchController,
                        //     searchMovie: searchMovie,
                        //     moviesBox: moviesBox,
                        //     selectedCatagory: selectedCatagory);
                      });
                    }),
                  ],
                ),
              ),
              ValueListenableBuilder(
                valueListenable: moviesBox.listenable(),
                builder: (context, box, child) => searchMovie.isEmpty
                    ? Center(
                        child: Text(
                          'No Movies Found',
                          style: GoogleFonts.ubuntu(color: Colors.white),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: searchMovie.length,
                            itemBuilder: (context, index) {
                              final movie = searchMovie[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return DetailsScreen(
                                            movie: movie,
                                            movieindex: index,
                                          );
                                        }));
                                      },
                                      child: SizedBox(
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.file(
                                              File(movie.imageUrl),
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return DetailsScreen(
                                              movieindex: index,
                                              movie: movie,
                                            );
                                          }));
                                        },
                                        child: Row(
                                          children: [
                                            detailsScectionText(
                                                '${movie.title} (${DateFormat('yyyy').format(movie.releaseyear)})',
                                                17,
                                                Colors.white)
                                          ],
                                        ),
                                      ),
                                    ),
                                    RatingAndGenereSection(
                                        movie.movierating.toString(),
                                        Icons.star,
                                        Colors.amber)
                                  ],
                                ),
                              );
                            }),
                      ),
              ),
            ])));
  }

  void search() {
    String query = searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      searchMovie = moviesBox.values
          .where((movie) =>
              movie.title.toLowerCase().contains(query) ||
              movie.releaseyear.toString().contains(query) ||
              movie.movierating.toString().contains(query))
          .toList();
    } else {
      searchMovie = selectedCatagory.isEmpty
          ? List.from(moviesBox.values)
          : moviesBox.values
              .where((movie) =>
                  movie.moviegenre.toLowerCase() ==
                      selectedCatagory.toLowerCase() ||
                  movie.movielanguage.toLowerCase() ==
                      selectedCatagory.toLowerCase())
              .toList();
    }
  }
}
