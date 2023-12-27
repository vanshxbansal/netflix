import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netflix/screens/movie_details.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}
class _SearchPageState extends State<SearchPage> {
  List<Widget> titlename = [];
  List<Widget> poster = [];
  TextEditingController movieseacrh = TextEditingController();
  Future<void> search() async {
    titlename = [];
    poster = [];
    Uri moviename = Uri.parse(movieseacrh.text);
    Uri url = Uri.parse(
        "https://api.themoviedb.org/3/search/movie?query=$moviename&api_key=03acf969899087a041625a8084ec04da");
    http.Response response = await http.get(url);
    String posterurl;
    var jsondata = response.body;
    List<dynamic> search = jsonDecode(jsondata)['results'];
    for (var result in search) {
      if (result['poster_path'] != null) {
        posterurl = result['poster_path'];
      } else {
        posterurl = "";
      }
      setState(() {
        if (posterurl != "") {
          poster.add(
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                child: Image.network(
                    'https://image.tmdb.org/t/p/w500$posterurl'),
              ),
            ),
          );
        }
      });
    }
  }
  @override
  void initState() {
    movieseacrh.clear();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MovieDetails();
              }));
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black),
      body: Column(
        children: [
          TextField(
            controller: movieseacrh,
            decoration: InputDecoration(
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white54,
                ),
                hintText: "Search Movies",
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.grey.shade700),
            style: TextStyle(color: Colors.white),
            onChanged: (value) async{
              if (value.isEmpty) {
                setState(() {
                  movieseacrh.clear();
                  poster = [];
                });
              }else {
                await search();
              }
            },
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: poster,
            ),
          ),
        ],
      ),
    );
  }
}

