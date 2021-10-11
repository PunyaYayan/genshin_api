import 'package:flutter/material.dart';
import 'package:genshin_api/CharModel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CharDetail extends StatefulWidget {
  final CharModel charModel;
  final int index;
  final Color appBarColor;

  const CharDetail({Key key, this.charModel, this.index, this.appBarColor})
      : super(key: key);

  @override
  _CharDetailState createState() => _CharDetailState();
}

class _CharDetailState extends State<CharDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: widget.appBarColor,
        title: Text("Detail Character"),
      ),
      body: SlidingUpPanel(
        minHeight: 75,
        maxHeight: 300,
        color: Colors.black45,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        panelBuilder: (controller) => PanelWidget(
          controller: controller,
          panelCharModel: widget.charModel,
          index: widget.index,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.charModel.payload.characters[widget.index]
                        .cardImageUrl,
                  ))),
        ),
      ),
    );
  }
}

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final CharModel panelCharModel;
  final int index;

  const PanelWidget({
    Key key,
    @required this.controller,
    this.panelCharModel,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Column(
          children: <Widget>[
            Text(
              panelCharModel.payload.characters[index].name.toUpperCase(),
              style: TextStyle(
                fontSize: 45,
                color: customColorText(
                    panelCharModel.payload.characters[index].element),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(panelCharModel.payload.characters[index].element,
                    style: TextStyle(
                        fontSize: 20,
                        color: customColorText(
                            panelCharModel.payload.characters[index].element))),
                Text(
                    " / " +
                        panelCharModel.payload.characters[index].weaponType
                            .toString()
                            .substring(11),
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ],
            ),
            Text(panelCharModel.payload.characters[index].birthday,
                style: TextStyle(fontSize: 20, color: Colors.white)),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                panelCharModel.payload.characters[index].description,
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Container(alignment: Alignment.bottomRight,child: Image.asset(displayVision(panelCharModel.payload.characters[index].element)),)
          ],
        ),
      );

  Color customColorText(String element) {
    switch (element) {
      case "Anemo":
        return Colors.greenAccent;
        break;
      case "Cryo":
        return Colors.lightBlue;
        break;
      case "Dendro":
        return Colors.green;
        break;
      case "Electro":
        return Colors.purple;
        break;
      case "Geo":
        return Colors.amber;
        break;
      case "Hydro":
        return Colors.lightBlueAccent;
        break;
      case "Pyro":
        return Colors.red;
        break;
      default:
        return Colors.white;
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
}
