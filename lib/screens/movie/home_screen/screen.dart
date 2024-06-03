import 'package:firstprojectcinephile/screens/movie/drawer.dart';
import 'package:firstprojectcinephile/screens/movie/function.dart';
import 'package:firstprojectcinephile/screens/movie/home_screen/widgets.dart';
import 'package:firstprojectcinephile/widgets/home_and_details_ref.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  FilterMovie searchfuction = FilterMovie();
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
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 233, 230, 230)),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: SizedBox(
                  width: 350,
                  height: 45,
                  child: searchBar((value) {
                    setState(() {
                      search();
                    });
                  }, searchController))),
        ),
        drawer: const Mydrawer(),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: detailsScectionText('Categories', 20, Colors.white),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 10),
              child: Row(
                children: [
                  catagoriesButton('All Movies', () {
                    setState(() {
                      selectedCatagory = '';
                      search();
                    });
                  }),
                  catagoriesButton('Action', () {
                    setState(() {
                      selectedCatagory = 'Action';
                      search();
                    });
                  }),
                  catagoriesButton('Comedy', () {
                    setState(() {
                      selectedCatagory = 'Comedy';
                      search();
                    });
                  }),
                  catagoriesButton('Horror', () {
                    setState(() {
                      selectedCatagory = 'Horror';
                      search();
                    });
                  }),
                  catagoriesButton('English', () {
                    setState(() {
                      selectedCatagory = 'English';
                      search();
                    });
                  }),
                  catagoriesButton('Hindi', () {
                    setState(() {
                      selectedCatagory = 'hindi';
                      search();
                    });
                  }),
                  catagoriesButton('Malayalam', () {
                    setState(() {
                      selectedCatagory = 'Malayalam';
                      search();
                    });
                  }),
                  catagoriesButton('Tamil', () {
                    setState(() {
                      selectedCatagory = 'Tamil';
                      search();
                    });
                  }),
                ],
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: moviesBox.listenable(),
            builder: (context, box, child) => searchMovie.isEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * .3,
                      ),
                      Center(
                        child: Text(
                          'No movies found',
                          style: GoogleFonts.ubuntu(
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 18)),
                        ),
                      ),
                    ],
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
                              children: [movieSection(context, movie, index)],
                            ),
                          );
                        }),
                  ),
          ),
        ]),
      ),
    );
  }

  void search() {
    setState(() {
      searchMovie = searchfuction.search(
          searchController.text, selectedCatagory, moviesBox);
    });
  }
}
