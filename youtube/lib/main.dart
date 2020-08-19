import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube/api.dart';
import 'package:youtube/blocs/favorite_block.dart';
import 'package:youtube/blocs/videos_bloc.dart';
import 'package:youtube/screens/home.dart';

void main() {
  Api api = Api();
  api.search("eletro");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: VideosBloc(),
        child: BlocProvider(
            bloc: FavoriteBloc(),
            child: MaterialApp(
                title: "FlutterTube",
                home: Home(),
                debugShowCheckedModeBanner: false)));
  }
}
