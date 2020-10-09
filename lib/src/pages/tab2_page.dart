import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_news_app/src/models/category_model.dart';
import 'package:provider_news_app/src/services/news_service.dart';
import 'package:provider_news_app/src/theme/dark_theme.dart';
import 'package:provider_news_app/src/widgets/news_list.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
          body: Column(
            children: [
              _CategoriesList(),
              Expanded(
                child: NewsList(newsService.articlesByCategorySelected),
              )
            ],
        ),
      ),
    );
  }
}

class _CategoriesList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      margin: EdgeInsets.only(top: 30),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int i) {
          final categoryName = categories[i].categoryName;
          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryIcon(categories[i]),
                SizedBox(height: 5),
                Text('${categoryName[0].toUpperCase()}${categoryName.substring(1)}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryIcon extends StatelessWidget {

  final Category category;
  const _CategoryIcon(this.category);

  @override
  Widget build(BuildContext context) {

  final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: (){
        print('${category.categoryName}');
        final newsService = Provider.of<NewsService>(context, listen: false); // listen = false, para eventos onX, para que no se redibujen
        newsService.selectedCategory = category.categoryName;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(
          category.icon,
          color: (newsService.selectedCategory == this.category.categoryName)
            ? darkTheme.accentColor
            : Colors.black54,
        ),
      ),
    );
  }
}