class Peliculas{
  List<Pelicula> items = new List();

  Peliculas();

  Peliculas.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) 
    {
      return;
    }else{
      for (var item in jsonList) {
        final pelicula = new Pelicula.fromJsonMap(item);
        items.add(pelicula);
      }
    }
  }
}

class Pelicula {
  String uniqueId;
  double popularity;
  int id;
  bool video;
  int voteCount;
  double voteAverage;
  String title;
  String releaseDate;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String posterPath;

  Pelicula({
    this.popularity,
    this.id,
    this.video,
    this.voteCount,
    this.voteAverage,
    this.title,
    this.releaseDate,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.posterPath,
  });

  Pelicula.fromJsonMap(Map<String,dynamic> json){
      popularity        =json["popularity"] / 1;
      id                =json["id"];
      video             =json["video"];
      voteCount         =json["vote_count"];
      voteAverage       =json["vote_average"] / 1;
      title             =json["title"];
      releaseDate       =json["release_date"];
      originalLanguage  =json["original_language"];
      originalTitle     =json["original_title"];
      genreIds          =json["genre_ids"].cast<int>();
      backdropPath      =json["backdrop_path"];
      adult             =json["adult"];
      overview          =json["overview"];
      posterPath        =json["poster_path"];
  }

  String getPosterImg(){
    if(posterPath != null){
      return 'https://image.tmdb.org/t/p/w500/$posterPath';  
    }else{
      return 'https://matthewsenvironmentalsolutions.com/images/com_hikashop/upload/not-available.png';
    }    
  }

  String getBackgroundImg(){
    if(backdropPath != null){
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';  
    }else{
      return 'https://matthewsenvironmentalsolutions.com/images/com_hikashop/upload/not-available.png';
    }    
  }
}
