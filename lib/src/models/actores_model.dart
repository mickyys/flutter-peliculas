class Cast{
  List<Actor> actores = new List();
  
  Cast.fromJsonList(List<dynamic> jsonList){
    
    if(jsonList == null) return;

    for (var item in jsonList) {
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    }
  }
}

class Actor {

  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  
  Actor.fromJsonMap(Map<String,dynamic> json){
    this.castId       = json['cast_id'];
    this.character    = json['character'];
    this.creditId     = json['credit_id'];
    this.gender       = json['gender'];
    this.id           = json['id'];
    this.name         = json['name'];
    this.order        = json['order'];
    this.profilePath  = json['profile_path'];
  }


  getPhoto(){
    if(profilePath == null){
      return 'http://i.imgur.com/HQ3YU7n.gif';
    }else{
      return 'https://image.tmdb.org/t/p/w500/$profilePath';  
    }
  }
}
