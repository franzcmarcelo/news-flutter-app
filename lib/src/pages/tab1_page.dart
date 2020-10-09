import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:provider_news_app/src/services/news_service.dart';
import 'package:provider_news_app/src/widgets/news_list.dart';

// Lo transformamos a un stateful, para poder mantener el estado del scroll, cuando cambiemos de pagina
// FIXME:
// Hacemos un mixin con AutomaticKeepAliveClientMixin
// Y hacemos que wantKeepAlive retorne true, para no matar el estado y siempre mantenerlo
class Tab1Page extends StatefulWidget {

  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {

  final newsService = Provider.of<NewsService>(context);
  final headlines = newsService.headlines;

    return Scaffold(
      body: ( headlines.length == 0 )
        ? Center( child: CircularProgressIndicator() )
        : Container(
            margin: EdgeInsets.only(top: 20),
            child: NewsList(headlines)
          ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}