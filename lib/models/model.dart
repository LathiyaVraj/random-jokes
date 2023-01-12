class Random_Jokes {
  final String id;
  final String myJokes;
  final String launchDate;
  final String editedDate;

  Random_Jokes({
    required this.launchDate,
    required this.id,
    required this.editedDate,
    required this.myJokes,
  });

  factory Random_Jokes.fromJson(Map<String, dynamic> json) {
    return Random_Jokes(
      id: json['Id'],
      myJokes: json['MyJokes'],
      launchDate: json['LaunchDate'],
      editedDate: json['Editeddate'],
    );
  }
}
