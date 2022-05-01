import 'package:flutter/material.dart';
import 'package:netflix_tutorial/model/model_movie.dart';
import 'package:netflix_tutorial/widget/box_slider.dart';
import 'package:netflix_tutorial/widget/carousel_slider.dart';
import 'package:netflix_tutorial/widget/circle_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// 넷플릭스의 홈화면 제작
class HomeScreen extends StatefulWidget{
  // 강의에서 영화의 데이터를 백엔드에서 가져와야하기에 라고 이야기
  //==> 백엔드에서 실시간으로 가져오기에 StatefulWidget으로 구현함
  _HomeScreenState createState() => _HomeScreenState();
  // _HomeScreen 타입의
}
class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> streamData;

  @override
  void initState(){
    super.initState();
    streamData = firestore.collection('movie').snapshots(); // snapshots()는 실시간으로 변경되는 DB의 데이터를 반영해서 읽어옴]
    // 가령 찜하기를 누르면 DB의 like가 false에서 true로 바뀌는 데 바뀌는 실시간으로 업데이트함
    //만약 안바뀐느 데이터를 읽어오고 싶으면 스냅샷이 아닌 get()을 쓴다
  }

  Widget _fetchData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('movie').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildBody(context, snapshot.data!.docs); //        return _buildBody(context, snapshot.data!.documents); >>
      },
    );
  }
  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Movie> movies = snapshot.map((d) => Movie.fromSnapshot(d)).toList();
    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            CarouselImage(movies: movies),
            TopBar(),
          ],
        ),
        CircleSlider(movies: movies),
        BoxSlider(movies: movies),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
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