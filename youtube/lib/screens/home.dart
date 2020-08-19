import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube/blocs/favorite_block.dart';
import 'package:youtube/blocs/videos_bloc.dart';
import 'package:youtube/delegates/data_search.dart';
import 'package:youtube/models/video.dart';
import 'package:youtube/screens/favorites.dart';
import 'package:youtube/widgets/video_tile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<VideosBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: Container(
              height: 25,
              child: Text(
                  "YouTube") //Image.asset("images/white-youtube-logo-png-clip-art.png"),

              ),
          elevation: 0,
          backgroundColor: Colors.black87,
          actions: <Widget>[
            Align(
                alignment: Alignment.center,
                child: StreamBuilder<Map<String, Video>>(
                    stream: BlocProvider.of<FavoriteBloc>(context).outFav,
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return Text("${snapshot.data.length}");
                      else
                        return Container();
                    })),
            IconButton(
              icon: Icon(Icons.star),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Favorites()));
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String result =
                    await showSearch(context: context, delegate: DataSearch());
                if (result != null) bloc.inSearch.add(result);
              },
            )
          ],
          //body: Container(),
        ),
        backgroundColor: Colors.black,
        body: StreamBuilder(
          stream: bloc.outVideos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemBuilder: (context, index) {
                    if (index < 10) //snapshot.data.lenght)
                    {
                      return VideoTile(snapshot.data[index]);
                    } else {
                      // //if(index > 1) {
                      bloc.inSearch.add(null);
                      return Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      );
                    }
                  },
                  itemCount: 11 //snapshot.data.length + 1,
                  );
            } else
              return Container();
          },
        ));
  }
}
