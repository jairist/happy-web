import 'package:flutter/material.dart';

Widget tickets(Color color, BuildContext context, IconData icon,
    int ticketsNumber, String newCount) {
  return Card(
    elevation: 2,
    child: Container(
      padding: EdgeInsets.all(22),
      color: color,
      width: MediaQuery.of(context).size.width < 1300
          ? MediaQuery.of(context).size.width - 100
          : MediaQuery.of(context).size.width / 5.5,
      height: MediaQuery.of(context).size.height / 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                icon,
                size: 40,
                color: Colors.white,
                
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                ticketsNumber.toString(),
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Raleway',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                newCount,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'HelveticaNeue',
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}