import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix_tutorial/screen/detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/model_movie.dart';
class CarouselImage extends StatefulWidget {
  // StatefulWidget 이유 : 영화의 사진뿐만 아니라 영화에 따라 나타나는 정보들이 다르므로 <장르, 찜 여부 등>
  final List<Movie> movies;
  CarouselImage({required this.movies});
  _CarouselImageState createState() => _CarouselImageState();

}
class _CarouselImageState extends State<CarouselImage>{

  late List<Movie> movies;  //text를 받는다
  late List<Widget> images;
  late List<String> keywords;
  late List<bool> likes;
  late String _currentKeyword;

  /*List<Movie> movies;
  List<Widget> images;
  List<String> keywords;
  List<bool> likes;
  String _currentKeyword;
  원래 코드 --> null safety때문에 바꿔줌
   */
  int _currentPage = 0; //CarouselImage에서 현재 사진의 index의 위치

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  CarouselImage 상위 satefullwidget class에서 가져온 영화들movies 을 참조함
    // 각 속성 영화제목 분류 등에 값을 넣어줌
    movies = widget.movies;
    images = movies.map((m) => Image.network(m.poster)).toList();
    keywords = movies.map((m) => m.keyword).toList();
    likes = movies.map((m) => m.like).toList();
    _currentKeyword = keywords[0];
  }

  @override
  Widget build(BuildContext context){
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
          ),

          CarouselSlider( // 자동 스크롤 슬라이더
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                  _currentKeyword = keywords[_currentPage];
                });
              }, //자동재생 여부
            ),
            items: images,
          ),
          /*
          CarouselSlider(
            items: images,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
                _currentKeyword = keywords[_currentPage];
              });
            }, options: null,
          ),*/

          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
            child: Text(
              _currentKeyword,
              style: TextStyle(fontSize: 11),
            ),
          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 가운데 같은 간격으로 배치함 없으면 한군데에 버튼들이 몰림
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      likes[_currentPage]
                          ? IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          setState(() {
                            likes[_currentPage] = !likes[_currentPage];
                            movies[_currentPage].reference.update( //updateData >> update로 수정하면됨
                                {'like': likes[_currentPage]});
                          });
                        },
                      )
                          : IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            likes[_currentPage] = !likes[_currentPage];
                            movies[_currentPage].reference.update(
                                {'like': likes[_currentPage]});
                          });
                        },
                      ),
                      Text(
                        '내가 찜한 콘텐츠',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: FlatButton(
                    color: Colors.white,
                    onPressed: () {}, // 해당 재생버튼을 누를 경우 발생하는 event 작성
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.all(3),
                        ),
                        Text(
                          '재생',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Container( // 목록 버튼
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.info),
                        onPressed: () { // 정보 버튼을 누를 경우, 발생하는 이벤트
                          Navigator.of(context).push( // 해당 코드를 circle_slider.dart와 box_slider.dart
                            //에 적용함으로 각 컨테이너에서 tap 즉 누르면 마찬가지로 상세설명이 뜨게함
                              MaterialPageRoute<Null>(
                                  fullscreenDialog: true,
                                  builder: (BuildContext context){
                                    return DetailScreen(movie: movies[_currentPage]);
                                  }
                                  )
                          );
                        },
                      ),
                      Text(
                        '정보',
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container( // indicator 즉 페이지 넘기면 밑의 원 색깔 바뀌는거
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: makeIndicator(likes, _currentPage),
              )),

        ],
      ),
    );
  }
}
List<Widget> makeIndicator(List list, int _currentPage) {
  List<Widget> results = [];
  for (var i = 0; i < list.length; i++) {
    results.add(Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == i
            ? Color.fromRGBO(255, 255, 255, 0.9) // i가 현재 페이지면 즉 현재페이지를 가리킨다면 0.9
            : Color.fromRGBO(255, 255, 255, 0.4),// i가 현재 페이지가 아니면 0.4
      ),
    ));
  }

  return results;
}