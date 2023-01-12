import 'dart:async';

import 'package:flutter/material.dart';

import '../helpers/api_helper.dart';
import '../models/model.dart';

class SavedJokes extends StatefulWidget {
  const SavedJokes({Key? key}) : super(key: key);

  @override
  State<SavedJokes> createState() => _SavedJokesState();
}

class _SavedJokesState extends State<SavedJokes> {
  late Future<Random_Jokes?> fetchedJokes;

  @override
  initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
    fetchedJokes = JokesApiHelper.jokes_api_helper.attach_Jokes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.yellowAccent,
        title: Text(
          "SAVED JOKES",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        color: Colors.greenAccent,
        child: FutureBuilder(
          future: fetchedJokes,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Random_Jokes data = snapshot.data as Random_Jokes;
              return Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.center,
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.green.shade900,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            data.myJokes,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                  child: Stack(
                alignment: Alignment.center,
                children: const [
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ],
              ));
            }
          },
        ),
      ),
    );
  }
}
