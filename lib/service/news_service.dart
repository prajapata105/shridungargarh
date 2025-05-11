import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/modelnews.dart';

class Newsservice extends GetxController{
    List<Articles> articalelist = [];
    Future<dynamic> newsfuncation()async{
        var url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=d8d8079e07404a19a08a03b1737d1fa9";
        var responce = await http.get(Uri.parse(url));
        final JsonDecoder _decoder = new JsonDecoder();
        var data = _decoder.convert(responce.body.toString());
        var filterdata = data['articles'];
        articalelist.clear();
        for (var i = 0; i <filterdata.length; i++) {
            Articles articles = Articles();
            articles.title = filterdata[i]["title"].toString();
            articles.content = filterdata[i]["content"].toString();
            articles.url = filterdata[i]["id"].toString();
            articles.description = filterdata[i]["description"].toString();
            articles.urlToImage = filterdata[i]["urlToImage"].toString();
            articalelist.add(articles);
            update();
        }
    }
}