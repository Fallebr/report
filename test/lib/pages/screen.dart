import 'package:flutter/material.dart';
import 'package:report/pages/Home.dart';

class Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              margin: EdgeInsets.only(top: 250, left: 100),
              padding: EdgeInsets.only(top: 10, left: 20),
              child: Image(
                image: AssetImage("img/KLlogo.png"),
              ),
            ),
            Container(
              width: 200,
              height: 45,
              margin: EdgeInsets.only(top: 500, left: 100),
              padding: EdgeInsets.only(top: 10, left: 20),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xffF18265),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return Home();
                  }), ModalRoute.withName('/'));
                },
                child: Text(
                  "MASUK",
                  style: TextStyle(
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
