import 'package:flutter/material.dart';
import 'package:netflix/utils/text.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class Description extends StatefulWidget {
  final String name,description, tmdbid, posterurl, vote, launch_on;
  const Description(
      {required this.name,
      required this.description,
      required this.tmdbid,
      required this.posterurl,
      required this.vote,
      required this.launch_on});
  @override
  State<Description> createState() => _DescriptionState();
}
class _DescriptionState extends State<Description> {
  late YoutubePlayerController youtubeController;
  void initState() {
    super.initState();
    youtubeController = YoutubePlayerController(
      initialVideoId: widget.tmdbid,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        loop: false,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          child: ListView(
        children: [
          Container(
            height: 280,
            child: Column(
              children: [
                Container(
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: YoutubePlayer(
                      controller: youtubeController,
                      showVideoProgressIndicator: true,
                    ),
                  ),
                ),
                Container(
                  child: modifiedText(
                      text: "⭐  Average Rating - " + widget.vote,
                      color: Colors.white,
                      size: 15),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: modifiedText(
              text: widget.name,
              size: 24,
              color: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: modifiedText(
                text: 'Release Date - '+widget.launch_on,
                color: Colors.white,
                size: 12),
          ),
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
              color: Colors.white10,),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: 200,
                  width: 130,
                  child: Image.network(widget.posterurl),
                ),
                Flexible(
                  child: Container(
                    child: modifiedText(text: widget.description, color: Colors.white, size: 13),
                  ),),],),),],)),);}}

