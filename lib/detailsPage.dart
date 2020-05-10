import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:firebase_database/firebase_database.dart';


class DetailsPage extends StatefulWidget {
  final heroTag;
  final foodName;
  final foodPrice;
  final DBRef = FirebaseDatabase.instance.reference();
  final foodPer=0.6;

  DetailsPage({this.heroTag, this.foodName, this.foodPrice});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var selectedCard = 'WEIGHT';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF7A9BEE),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('Container Details',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 22.0,
                  color: Colors.white)),
          centerTitle: true,
          actions: <Widget>[
          ],
        ),
        body: ListView(children: [
          Stack(children: [
            Container(
                height: MediaQuery.of(context).size.height - 83.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent),
            Positioned(
                top: 20.0, //75
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0),
                        ),
                        color: Colors.white),
                    height: MediaQuery.of(context).size.height - 100.0,
                    width: MediaQuery.of(context).size.width)),
            Positioned(
                top: 30.0,
                left: (MediaQuery.of(context).size.width / 2) - 100.0,
                child: Hero(
                    tag: widget.heroTag,
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(widget.heroTag),
                                fit: BoxFit.cover)),
                        height: 200.0,
                        width: 200.0))),
            Positioned(
                top: 250.0,
                left: 25.0,
                right: 25.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(widget.foodName,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold)),

                    SizedBox(height: 20.0),
                    CircularPercentIndicator(
                      radius: 140.0,
                      lineWidth: 15.0,
                      animation: true,
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.indigo[400],

                      percent:widget.foodPer,

                      center: new Text(
                        widget.foodPrice,
                        style:
                        new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      footer: new Text(
                        '18 Days Left',
                        style:
                        new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                      ),
                      addAutomaticKeepAlive: true,

                    )


                  ],
                ))
          ])
        ]));
  }


  Widget _buildInfoCard(String cardTitle, String info, String unit) {
    return InkWell(
      onTap: () {
        selectCard(cardTitle);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: cardTitle == selectedCard ? Color(0xFF7A9BEE) : Colors.white,
          border: Border.all(
            color: cardTitle == selectedCard ? 
            Colors.transparent :
            Colors.grey.withOpacity(0.3),
            style: BorderStyle.solid,
          width: 0.75
          ),
          
        ),
        height: 100.0,
        width: 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 15.0),
              child: Text(cardTitle,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12.0,
                    color:
                        cardTitle == selectedCard ? Colors.white : Colors.grey.withOpacity(0.7),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(info,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14.0,
                          color: cardTitle == selectedCard
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold)),
                  Text(unit,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12.0,
                        color: cardTitle == selectedCard
                            ? Colors.white
                            : Colors.black,
                      ))
                ],
              ),
            )
          ]
        )
      )
    );
  }

  selectCard(cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }
}

