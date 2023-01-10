import 'dart:async';

import 'package:flutter/material.dart';

import 'api_helper.dart';
import 'model.dart';

class AllJokes extends StatefulWidget {
  const AllJokes({Key? key}) : super(key: key);

  @override
  State<AllJokes> createState() => _AllJokesState();
}

class _AllJokesState extends State<AllJokes> {
  late Future<RandomJokes?> fetchedJokes;

  @override
  initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
    fetchedJokes = APIHelper.apiHelper.fetchJokes();
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
        backgroundColor: Colors.yellow,
        title: Text(
          "SAVED JOKES",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        color: Colors.black,
        child: FutureBuilder(
          future: fetchedJokes,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              RandomJokes data = snapshot.data as RandomJokes;
              return Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Container(
                        alignment: Alignment.center,
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.yellow,
                                  blurRadius: 20,
                                  spreadRadius: 1),
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            data.jokes,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              shadows: [
                                BoxShadow(
                                  blurRadius: 20,
                                  color: Colors.yellowAccent,
                                  spreadRadius: 20,
                                )
                              ],
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
