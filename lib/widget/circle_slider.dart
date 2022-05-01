

import 'package:flutter/material.dart';

import '../model/model_movie.dart';
import '../screen/detail_screen.dart';

class CircleSlider extends StatelessWidget{
  late final List<Movie> movies;
  CircleSlider({required this.movies});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('미리보기'),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: makeCircleImages(context, movies),
            ),
          ),
        ],
      ),
    );
  }
}
List<Widget> makeCircleImages(BuildContext context, List<Movie> movies) {
  List<Widget> results = [];
  for (var i = 0; i < movies.length; i++) {
    results.add(
      InkWell(// results의 각 원소들 즉 원형으로 만들어진 영화사진들을 클릭가능하게 클릭가능한 속성을 붙여준다
        onTap: () { // 원 모양의 영화 사진들을 tap 즉 누른다면 아래와 같은 일이 일어난다
          // 아래는 영화의 상세 설명을 띄워주는 코드이다
          Navigator.of(context).push(
              MaterialPageRoute<Null>(
                  fullscreenDialog: true,
                  builder: (BuildContext context){
                    return DetailScreen(movie: movies[i]);
                  }
              )
          );
        },
        child: Container(
          padding: EdgeInsets.only(right: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              backgroundImage: NetworkImage(movies[i].poster), //movies의 현재 순서 영화의 사진을 가져와서 배경사진으로 설정
              radius: 48,
            ),
          ),
        ),
      ),
    );
  }
  return results;
}