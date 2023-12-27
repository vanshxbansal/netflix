import 'package:flutter/material.dart';
import 'package:netflix/screens/description.dart';
import 'package:netflix/utils/text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
late String yid;
late String ideez ;
class TopRatedMovies extends StatefulWidget {
  const TopRatedMovies({super.key, required this.topRated});
  final List topRated;
  @override
  State<TopRatedMovies> createState() => _TopRatedMoviesState();
}
class _TopRatedMoviesState extends State<TopRatedMovies> {
  getid(index) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.kinocheck.de/movies?tmdb_id=${widget.topRated[index]['id']}&language=de&categories=Trailer'));
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
            text: "Top Rated Movies",
            size: 26,
            color: Colors.white54,
          ),
          Container(
            height: 270,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.topRated.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async{
                      yid=await getid(index);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Description(
                            name: widget.topRated[index]['title']!=null?widget.topRated[index]['title']:widget.topRated[index]['name'],
                            description: widget.topRated[index]['overview'],
                            tmdbid: yid.toString(),
                            posterurl: 'https://image.tmdb.org/t/p/w500'+widget.topRated[index]['poster_path'],
                            vote: widget.topRated[index]['vote_average'].toString(),
                            launch_on: widget.topRated[index]['release_date']==null?"Not Known": widget.topRated[index]['release_date'],
                          ),),);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: 140,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500' + widget.topRated[index]['backdrop_path']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                              child: modifiedText(
                                text: widget.topRated[index]['title']!=null?widget.topRated[index]['title']:widget.topRated[index]['name'],
                                color: Colors.white,
                                size: 14,)),
                        ],
                      ),
                    ),
                  );
                }),)],),
    );
  }
}
