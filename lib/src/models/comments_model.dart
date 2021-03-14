import 'package:flutter/material.dart';

class CommentModel {
  final String user;
  final String comment;
  //final DateTime time;
  //TO DO: final Icon  imagen;

  const CommentModel({
    @required this.user,
    @required this.comment,
    //@required this.time,
  });
}