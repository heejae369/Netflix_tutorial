import 'package:flutter/material.dart';
import 'package:netflix_tutorial/model/model_movie.dart';
import 'package:netflix_tutorial/widget/box_slider.dart';
import 'package:netflix_tutorial/widget/carousel_slider.dart';
import 'package:netflix_tutorial/widget/circle_slider.dart';
// 넷플릭스의 홈화면 제작
class HomeScreen extends StatefulWidget{
  // 강의에서 영화의 데이터를 백엔드에서 가져와야하기에 라고 이야기
  //==> 백엔드에서 실시간으로 가져오기에 StatefulWidget으로 구현함
  _HomeScreenState createState() => _HomeScreenState();
  // _HomeScreen 타입의
}
class _HomeScreenState extends State<HomeScreen> {
  List<Movie> movies = [
    Movie.fromMap({
      'title': '재와 환상의 그림갈',
      'keyword': '애니/판타지/이세계',
      'poster': 'home_movie.jpg', // images/ 가 들어가야 정확한 경로로 인식되어 앱에서 제대로 인식한다
      'like': false
      //'영상쓰' :
    }),
    Movie.fromMap({
      'title': '재와 환상의 그림갈',
      'keyword': '애니/판타지/이세계',
      'poster': 'home_movie.jpg',
      'like': false
    }),
    Movie.fromMap({
      'title': '재와 환상의 그림갈',
      'keyword': '애니/판타지/이세계',
      'poster': 'home_movie.jpg',
      'like': false
    }),
    Movie.fromMap({
      'title': '재와 환상의 그림갈',
      'keyword': '애니/판타지/이세계',
      'poster': 'home_movie.jpg',
      'like': false
    })
  ];
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build (BuildContext context){ //위젯들을 화면에 띄움
    return ListView(children: <Widget>[
      Stack(
        children: <Widget>[
          CarouselImage(movies: movies,),
          TopBar(),
        ],
      ),
      CircleSlider(movies: movies,),
      BoxSlider(movies: movies),
    ],
    );
    //return TopBar();
  }
}
/*
class TopBar extends StatelessWidget{ // 탑 바는 홈화면에만 있기에 홈화면을 주관하는 이 파일에 탑바 만듬
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(children: <Widget>[

      ],),
    )
  }

}*/

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            'images/Netflix.png',
            fit: BoxFit.contain,
            height: 25,
          ),
          Container( // 탑바에서 TV프로그램 한칸
            padding: EdgeInsets.only(right: 1),
            child: Text(
              'TV 프로그램',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '영화',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '내가 찜한 콘텐츠',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}