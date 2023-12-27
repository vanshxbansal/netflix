import 'package:flutter/material.dart';
import 'movie_details.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final List<String> name = ["Ojas", "Devanshi","Ayushi","Karan"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset("assets/netflix_logo.png",
            fit: BoxFit.contain, height: 80),
        actions: [
          Icon(
            Icons.edit,
            color: Colors.white,
            size: 40,
          )
        ],
        centerTitle: true,
      ),
      body: Center(
        child: GridView.builder(
          itemCount: 4,
          padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 32.0),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.0,
            mainAxisSpacing: 32.0,
            crossAxisSpacing: 8.0,
            crossAxisCount: 2,),
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MovieDetails();
                  }));},
                child: Column(
                  children: [
                    Expanded(child: Image.asset("assets/user$index.jpg")),
                    SizedBox(height: 5.0),
                    Text(name[index], style: TextStyle(color: Colors.white),),
                  ],),
              ),
            );
          },
        ),
      ),
    );
  }
}
