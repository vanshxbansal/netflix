import 'package:flutter/material.dart';
import 'package:netflix/widgets/toprated.dart';
import 'package:netflix/widgets/trending.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'search_page.dart';
class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key});
  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}
class _MovieDetailsState extends State<MovieDetails> {
  List trendingMovies = [];
  List topRatedMovies = [];
  final String apikey = '03acf969899087a041625a8084ec04da';
  final readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwM2FjZjk2OTg5OTA4N2EwNDE2MjVhODA4NGVjMDRkYSIsInN1YiI6IjY1NTQ1OTNiMDgxNmM3MDExYTBiNWQ4OCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qzTn73OFGIMmjQjN95dXh3kzlLfkmWuEQbqUyWgSXOE';
  @override
  void initState() {
    loadMovies();
    super.initState();
  }
  loadMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),);
    Map trendingResult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topRatedResult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    setState(() {
      trendingMovies = trendingResult['results'];
      topRatedMovies = topRatedResult['results'];
    });
  }
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.black54,
      appBar: AppBar( backgroundColor: Colors.black,
        leading: Image.asset("assets/netflix_symbol.png", fit: BoxFit.contain),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage();
              }));},
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 35,
            ),),],
      ),
      body: ListView(
        children:[
        TrendingMovies(trending:trendingMovies),
        TopRatedMovies(topRated: topRatedMovies),
        ],),);}
}



