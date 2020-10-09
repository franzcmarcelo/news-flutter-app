import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider_news_app/src/models/category_model.dart';
import 'package:provider_news_app/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS_API = 'https://newsapi.org/v2';
final _API_KEY = '0b58a7f25cbc45ff99197d5feb570726';

class NewsService with ChangeNotifier {

  // HEADLINES
  List<Article> headlines = [];

  // CATEGORIES
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};
  // {'business': List<Article>}

  bool _isLoading = true;

  NewsService() {
    this.getTopHeadlines();
    // Inicializamos nuestro objeto de categorias, ayudandonos de nuestra lista de categorias
    categories.forEach((item) {
      this.categoryArticles[item.categoryName] = new List();
    });
    this.getArticlesByCategory(this._selectedCategory);
  }

  // HEADLINES
  getTopHeadlines() async {
    final url ='$_URL_NEWS_API/top-headlines?apiKey=$_API_KEY&country=US';

    final res = await http.get(url);

    final newsResponse = newsResponseFromJson(res.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  // CATEGORIES
  get selectedCategory => this._selectedCategory;
  set selectedCategory(String value){
    this._isLoading = true;
    this._selectedCategory = value;
    this.getArticlesByCategory(value);
    notifyListeners();
  }

  getArticlesByCategory( String category ) async {

    if ( this.categoryArticles[category].length > 0 ) {
      // Si ya tenemos data cargada
      this._isLoading = false;
      return this.categoryArticles[category];
    }

    final url ='$_URL_NEWS_API/top-headlines?apiKey=$_API_KEY&country=US&category=$category';

    final res = await http.get(url);

    final newsResponse = newsResponseFromJson(res.body);

    this.categoryArticles[category].addAll(newsResponse.articles);

    this._isLoading = false;
    notifyListeners();
  }

  // Para obtener la lista con la data de Article spor categoria
  List<Article> get articlesByCategorySelected => this.categoryArticles[this.selectedCategory];

  bool get isLoading => this._isLoading;

}