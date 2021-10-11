import 'dart:convert';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'CharDetail.dart';
import 'CharModel.dart';

class CharList extends StatefulWidget {
  const CharList({Key key}) : super(key: key);

  @override
  _CharListState createState() => _CharListState();
}

class _CharListState extends State<CharList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadFromJson();
  }

  bool isloading = true;
  CharModel charModel;

  void loadFromJson() async {
    final res = await http
        .get(Uri.parse("https://genshin-app-api.herokuapp.com/api/characters"));
    if (res.statusCode == 200) {
      isloading = false;
      charModel = CharModel.fromJson(json.decode(res.body.toString()));
      setState(() {
        isloading = false;
      });
    } else {
      print("Error Load Json");
    }
  }

  String displayVision(String textVision) {
    switch (textVision) {
      case "Anemo":
        return "assets/Vision/Element_Anemo.png";
        break;
      case "Cryo":
        return "assets/Vision/Element_Cryo.png";
        break;
      case "Dendro":
        return "assets/Vision/Element_Dendro.png";
        break;
      case "Electro":
        return "assets/Vision/Element_Electro.png";
        break;
      case "Geo":
        return "assets/Vision/Element_Geo.png";
        break;
      case "Hydro":
        return "assets/Vision/Element_Hydro.png";
        break;
      case "Pyro":
        return "assets/Vision/Element_Pyro.png";
        break;
      default:
        return "null";
    }
  }

  Color displayColor(int rarity) {
    if (rarity == 5) {
      return Color(0xffFFB800).withOpacity(0.7);
    } else {
      return Color(0xffC447FF).withOpacity(0.5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff2c2c2c),
        body: isloading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Image.asset(
                            "assets/LogoGenshin/White.png",
                            width: 200,
                            fit: BoxFit.cover,
                          )),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Characters",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: charModel.payload.characters.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CharDetail(
                                        charModel: charModel,
                                        index: index,
                                        appBarColor: displayColor(charModel.payload
                                            .characters[index].rarity),
                                      )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                alignment: AlignmentDirectional.center,
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: displayColor(charModel.payload
                                              .characters[index].rarity),
                                          border: Border.all(color: Colors.white,width: 2),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          charModel.payload.characters[index]
                                              .iconUrl,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    //Stroke Text
                                    Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Stack(
                                        children: <Widget>[
                                          //outline
                                          Text(
                                            charModel
                                                .payload.characters[index].name,
                                            style: TextStyle(
                                                fontSize: 18,
                                                foreground: Paint()
                                                  ..style = PaintingStyle.stroke
                                                  ..strokeWidth = 3),
                                          ),
                                          //Warna dasar
                                          Text(
                                            charModel
                                                .payload.characters[index].name,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      alignment: Alignment.topRight,
                                      child: Image.asset(
                                        displayVision(charModel
                                            .payload.characters[index].element),
                                        width: 30,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )));
  }
}
