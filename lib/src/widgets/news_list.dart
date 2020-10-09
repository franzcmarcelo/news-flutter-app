import 'package:flutter/material.dart';
import 'package:provider_news_app/src/models/news_models.dart';
import 'package:provider_news_app/src/theme/dark_theme.dart';

class NewsList extends StatelessWidget {

  final List<Article> news;
  const NewsList(this.news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.news.length,
      itemBuilder: (BuildContext context, int i) {
        return _NewItem(newItem: this.news[i], index: i);
      },
    );
  }
}

class _NewItem extends StatelessWidget {

  final Article newItem;
  final int index;

  const _NewItem({
    @required this.newItem,
    @required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CardTopBar(newItem, index),
        _CardTitle(newItem),
        _CardImage(newItem),
        _CardDescription(newItem),
        _CardButtons(),
        SizedBox(height: 10),
        Divider(),
      ],
    );
  }
}

class _CardTopBar extends StatelessWidget {

  final Article newItem;
  final int index;
  const _CardTopBar(this.newItem, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index+1}. ', style: TextStyle(color: darkTheme.accentColor),),
          Text('${newItem.source.name}. '),
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {

  final Article newItem;
  const _CardTitle(this.newItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(newItem.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
    );
  }
}

class _CardImage extends StatelessWidget {

  final Article newItem;
  const _CardImage(this.newItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
          child: ( newItem.urlToImage != null )
          ? FadeInImage(
              placeholder: AssetImage('assets/img/giphy.gif'),
              image: NetworkImage(newItem.urlToImage)
            )
          : Image(image: AssetImage('assets/img/no-image.png'))
        ),
      ),
    );
  }
}

class _CardDescription extends StatelessWidget {

  final Article newItem;
  const _CardDescription(this.newItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text( (newItem.description != null) ? newItem.description : '' ),
    );
  }
}

class _CardButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: (){},
            fillColor: darkTheme.accentColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.star_border),
          ),
          SizedBox(width: 10),
          RawMaterialButton(
            onPressed: (){},
            fillColor: darkTheme.accentColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.more),
          ),
        ],
      ),
    );
  }
}