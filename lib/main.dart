import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:netflix_tutorial/screen/home_screen.dart';
import 'package:netflix_tutorial/screen/more_screen.dart';
import 'package:netflix_tutorial/widget/bottom_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatefulWidget{
  // StatefulWidget 동적인 변화 가능한 위젯, UI가 실시간으로 바뀜
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  late TabController controller;
  //late TabController controller; //기존 코드 : TabController controller;
  @override
  Widget build(BuildContext context){
    return MaterialApp(title: 'HeeFlix',
    theme: ThemeData(
      brightness:  Brightness.dark,
      primaryColor: Colors.black,
      accentColor: Colors.white,
    ),
    home: DefaultTabController(
      length: 4, // 밑에 오는 네비게이션 바 목록 갯수
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            HomeScreen(),
            Container(),
            Container(),
            MoreScreen(),
          ],
        ),
        bottomNavigationBar: Bottom(), //
      ),

    ),
    );
  }
}

