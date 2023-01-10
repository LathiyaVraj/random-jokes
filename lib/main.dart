import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_helper.dart';
import 'jokes_page.dart';
import 'model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedJokes = prefs.getString('savedJokes') ?? "";
  await prefs.setString('savedJokes', savedJokes);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => jokesPage(),
        'allJokes': (context) => AllJokes(),
      },
    ),
  );
}

class jokesPage extends StatefulWidget {
  const jokesPage({Key? key}) : super(key: key);

  @override
  State<jokesPage> createState() => _jokesPageState();
}

class _jokesPageState extends State<jokesPage> {
  late Future<RandomJokes?> fetchedJokes;
  TextStyle myTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  final TextEditingController timeController = TextEditingController();
  final TextEditingController jokesController = TextEditingController();

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
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'JOKES',
          style: TextStyle(
              shadows: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.yellow,
                  spreadRadius: 10,
                )
              ],
              letterSpacing: 3,
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                await prefs.setString('savedJokes', "");

                Navigator.of(context).pushNamed('allJokes');
              },
              icon: const Icon(
                Icons.list,
                color: Colors.yellow,
                size: 30,
              )),
        ],
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black,
        height: double.infinity,
        child: FutureBuilder(
          future: fetchedJokes,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error : ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              RandomJokes data = snapshot.data as RandomJokes;
              return Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      Image.network(
                          "https://cdn.pixabay.com/photo/2020/02/09/09/38/smiley-4832492_1280.png",
                          height: 180),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            fetchedJokes = APIHelper.apiHelper.fetchJokes();
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "FETCH MY LAUGH",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              shadows: [
                                BoxShadow(
                                  blurRadius: 20,
                                  color: Colors.yellowAccent,
                                  spreadRadius: 20,
                                )
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.yellow,
                                    blurRadius: 20,
                                    spreadRadius: 1),
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          width: 200,
                          height: 80,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        height: 60,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.yellow,
                                  blurRadius: 20,
                                  spreadRadius: 1),
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            const SizedBox(width: 15),
                            const Text(
                              "CREATED ON :  ",
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
                            Text(
                              data.createdAt,
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
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        padding: EdgeInsets.all(5),
                        height: 60,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.yellow,
                                  blurRadius: 20,
                                  spreadRadius: 1),
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            const SizedBox(width: 15),
                            const Text(
                              "UPDATED ON :  ",
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
                            Text(
                              data.updatedAt,
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.center,
                        height: 100,
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
                      const SizedBox(height: 20),
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
