import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_modal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';

class PeliculasProvider {
  String _apiKey = "6a608d5e0f6ccc80f78d5e1fcdcd3e10";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;
 
  void disposeStream(){
    _popularesStreamController?.close();
  }


  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        final peliculas = new Peliculas.fromJsonList(jsonResponse['results']);
        return peliculas.items;
      } else {      
        print("Request failed with status: ${response.statusCode}.");
        return [];
      }   
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, "/3/movie/now_playing",
        {"api_key": _apiKey, "language": _language, "page": "1"});

    return await _procesarRespuesta(url);    
  }

   Future<List<Pelicula>> getPopulares() async {

    if(_cargando) return [];

    _cargando = true;
    _popularesPage++;
    print('Cargando datos ...');

    final url = Uri.https(_url, "/3/movie/popular",
      {
        "api_key": _apiKey, 
        "language": _language, 
        "page": _popularesPage.toString() 
      });

    final resp = await _procesarRespuesta(url);  

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;
    return resp;  
  }

  Future<List<Actor>> getCast(String id) async {
    final url = Uri.https(_url, "/3/movie/$id/credits",
      {
        "api_key": _apiKey, 
        "language": _language, 
      });

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final cast = new Cast.fromJsonList(jsonResponse['cast']);
      return cast.actores;
    }else{
       print("Request failed with status: ${response.statusCode}.");
       return [];
    }
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, "/3/search/movie", {
          "api_key": _apiKey, 
          "language": _language, 
          "query": query
    });

    return await _procesarRespuesta(url);    
  }
}
