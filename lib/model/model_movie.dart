
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Movie {
  final String title;
  final String keyword;
  final String poster;
  final bool like;
  final String videolink;
  final String crew;
  final DocumentReference reference;

  Movie.fromMap(Map<String, dynamic> map, {required this.reference}) //Movie.fromMap(Map<String, dynamic> map, {this.reference})
      : title = map['title'],
        keyword = map['keyword'],
        poster = map['poster'],
        like = map['like'],
        videolink = map['videolink'],
        crew = map['crew'];

        //'영상쓰' :


  Movie.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);
  /*
  Movie.fromMap(Map<String, dynamic> map, {required this.reference})
      : title = map['title'],
        keyword = map['keyword'],
        poster = map['poster'],
        like = map['like'];

  Movie.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
*/
  @override
  String toString() => "Movie<$title:$keyword>";


}