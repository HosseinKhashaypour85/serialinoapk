class ActorsModel {
  final String? image;
  final String actorName;

  ActorsModel({required this.image, required this.actorName});

  static List<ActorsModel> actorsModel = [
    ActorsModel(
      image: 'assets/images/actors/henrycavill.jpg',
      actorName: 'henry cavill',
    ),
    ActorsModel(
      image: 'assets/images/actors/benafflec.jpg',
      actorName: 'ben afflec',
    ),
    ActorsModel(
      image: 'assets/images/actors/scarlet.jpg',
      actorName: 'scatlett johanson',
    ),
    ActorsModel(
      image: 'assets/images/actors/sylvester.jpg',
      actorName: 'sylvester stallone',
    ),
  ];
}
