class HomeModel {
  HomeModel({
      this.title, 
      this.year, 
      this.rated, 
      this.released, 
      this.runtime, 
      this.genre, 
      this.director, 
      this.writer, 
      this.actors, 
      this.plot, 
      this.language, 
      this.country, 
      this.awards, 
      this.poster, 
      this.ratings, 
      this.metascore, 
      this.imdbRating, 
      this.imdbVotes, 
      this.imdbID, 
      this.type, 
      this.dvd, 
      this.boxOffice, 
      this.production, 
      this.website, 
      this.response,});

  HomeModel.fromJson(dynamic json) {
    title = json['Title'];
    year = json['Year'];
    rated = json['Rated'];
    released = json['Released'];
    runtime = json['Runtime'];
    genre = json['Genre'];
    director = json['Director'];
    writer = json['Writer'];
    actors = json['Actors'];
    plot = json['Plot'];
    language = json['Language'];
    country = json['Country'];
    awards = json['Awards'];
    poster = json['Poster'];
    if (json['Ratings'] != null) {
      ratings = [];
      json['Ratings'].forEach((v) {
        ratings?.add(Ratings.fromJson(v));
      });
    }
    metascore = json['Metascore'];
    imdbRating = json['imdbRating'];
    imdbVotes = json['imdbVotes'];
    imdbID = json['imdbID'];
    type = json['Type'];
    dvd = json['DVD'];
    boxOffice = json['BoxOffice'];
    production = json['Production'];
    website = json['Website'];
    response = json['Response'];
  }
  String? title;
  String? year;
  String? rated;
  String? released;
  String? runtime;
  String? genre;
  String? director;
  String? writer;
  String? actors;
  String? plot;
  String? language;
  String? country;
  String? awards;
  String? poster;
  List<Ratings>? ratings;
  String? metascore;
  String? imdbRating;
  String? imdbVotes;
  String? imdbID;
  String? type;
  String? dvd;
  String? boxOffice;
  String? production;
  String? website;
  String? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Title'] = title;
    map['Year'] = year;
    map['Rated'] = rated;
    map['Released'] = released;
    map['Runtime'] = runtime;
    map['Genre'] = genre;
    map['Director'] = director;
    map['Writer'] = writer;
    map['Actors'] = actors;
    map['Plot'] = plot;
    map['Language'] = language;
    map['Country'] = country;
    map['Awards'] = awards;
    map['Poster'] = poster;
    if (ratings != null) {
      map['Ratings'] = ratings?.map((v) => v.toJson()).toList();
    }
    map['Metascore'] = metascore;
    map['imdbRating'] = imdbRating;
    map['imdbVotes'] = imdbVotes;
    map['imdbID'] = imdbID;
    map['Type'] = type;
    map['DVD'] = dvd;
    map['BoxOffice'] = boxOffice;
    map['Production'] = production;
    map['Website'] = website;
    map['Response'] = response;
    return map;
  }

}

class Ratings {
  Ratings({
      this.source, 
      this.value,});

  Ratings.fromJson(dynamic json) {
    source = json['Source'];
    value = json['Value'];
  }
  String? source;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Source'] = source;
    map['Value'] = value;
    return map;
  }

}