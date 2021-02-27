import 'dart:ui';

import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('World of Flutter'),
        ),
        body: Column(
          children: [
            Center(
                child: Container(
                    margin: EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Flutter GOD",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 24.0,
                          fontFamily: 'Sans',
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.none),
                    ))),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Image(image: AssetImage('images/image_one.png')),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: () => onButtonClicked(context),
                color: Colors.deepPurple,
                elevation: 6.0,
                child: Text(
                  "Check Wifi",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Sans',
                      fontWeight: FontWeight.w700),
                ),
              ),
            )
          ],
        ));
  }

  void onButtonClicked(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text(
        'Wifi Settings',
        style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontFamily: 'Sans',
            fontWeight: FontWeight.w700),
      ),
      titlePadding: EdgeInsets.all(16.0),
      content: Text(
        'Please check your wifi settings',
        style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontFamily: 'Sans',
            fontWeight: FontWeight.w400),
      ),
      contentPadding: EdgeInsets.all(16.0),
    );

    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }
}
