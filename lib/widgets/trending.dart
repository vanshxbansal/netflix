import 'package:flutter/material.dart';
import 'package:netflix/screens/description.dart';
import 'package:netflix/utils/text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
late String yid;
late String ideez ;
class TrendingMovies extends StatefulWidget {
  const TrendingMovies({super.key, required this.trending});
  final List trending;
  @override
  State<TrendingMovies> createState() => _TrendingMoviesState();
}
class _TrendingMoviesState extends State<TrendingMovies> {
  getid(index) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.kinocheck.de/movies?tmdb_id=${widget.trending[index]['id']}&language=de&categories=Trailer'));
    print(response.body);
    setState(() {
      try{
      yid = jsonDecode(response.body)['trailer']['youtube_video_id'];
      }
      catch(e)
      {
        yid = "22z31vdqnWI";
      }
    });
  return yid;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modifiedText(
            text: "Trending Movies",
            size: 26,
            color: Colors.white54,
          ),
          Container(
            height: 270,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.trending.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async{

                       yid=await getid(index);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Description(
                            name: widget.trending[index]['title']!=null?widget.trending[index]['title']:widget.trending[index]['name'],
                            description: widget.trending[index]['overview'],
                            tmdbid: yid.toString(),
                            posterurl: 'https://image.tmdb.org/t/p/w500'+widget.trending[index]['poster_path'],
                            vote: widget.trending[index]['vote_average'].toString(),
                            launch_on: widget.trending[index]['release_date']==null?"Not Known": widget.trending[index]['release_date'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(8), width: 250,
                      child: Column( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500' +
                                        widget.trending[index]['backdrop_path']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                              child: modifiedText(
                                text: widget.trending[index]['title']!=null?widget.trending[index]['title']:widget.trending[index]['name'],
                                color: Colors.white,
                                size: 14,
                              )),],),),);}),)],),);
  }
}
