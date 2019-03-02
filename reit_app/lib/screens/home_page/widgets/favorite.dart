import 'package:flutter/material.dart';
import 'package:reit_app/models/reit_favorite.dart';
import 'package:reit_app/services/favorite_services.dart';
import 'package:reit_app/screens/detail_reit/detail_reit.dart';

class Favorite extends StatefulWidget {
  final Function emptyReit;
  const Favorite({Key key, this.emptyReit}) : super(key: key);
  @override
  FavoriteState createState() {
    return FavoriteState();
  }
}

class FavoriteState extends State<Favorite> {
  List<ReitFavorite> reitsFavorite = List();
  @override
  void initState() {
    super.initState();
    getReitFavoriteByUserId('1').then((result) {
      reitsFavorite = result;
      checkEmptyReit();
    });
  }

  deleteCard(reit) {
    setState(() {
      reitsFavorite.remove(reit);
      checkEmptyReit();
    });
  }

  checkEmptyReit() {
    bool value;
    if (reitsFavorite.length == 0) {
      value = true;
    } else {
      value = false;
    }
    widget.emptyReit(value);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
      },
      child: Expanded(
        child: ListView.builder(
            itemBuilder: (context, index) => ReitRow(
                  reitFavorite: reitsFavorite[index],
                  deleteCard: deleteCard,
                ),
            itemCount: reitsFavorite.length,
            padding: EdgeInsets.symmetric(vertical: 16.0)),
      ),
    );
  }
}

class ReitRow extends StatefulWidget {
  final ReitFavorite reitFavorite;
  final Function deleteCard;

  const ReitRow({Key key, this.reitFavorite, this.deleteCard})
      : super(key: key);

  @override
  ReitRowState createState() {
    return ReitRowState();
  }
}

class ReitRowState extends State<ReitRow> {
  @override
  Widget build(BuildContext context) {
    final baseTextStyle = const TextStyle(fontFamily: 'Poppins');

    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500);

    final regularTextStyle = baseTextStyle.copyWith(
        color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400);

    final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 16.0);
    Widget _reitValue({String value}) {
      return Row(children: <Widget>[
        Expanded(
          child: Text(value, style: regularTextStyle),
        ),
      ]);
    }

    final reitCardContent = Container(
      margin: EdgeInsets.fromLTRB(20.0, 16.0, 16.0, 16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.reitFavorite.ticker,
                  style: headerTextStyle,
                ),
                IconButton(
                  icon: Icon(
                    Icons.star,
                    color: Colors.blue,
                    size: 30,
                  ),
                  tooltip: 'Delete Favorite',
                  onPressed: () {
                    this.widget.deleteCard(widget.reitFavorite);
                  },
                ),
              ],
            ),
          ],
        ),
        Text(widget.reitFavorite.ticker, style: subHeaderTextStyle),
        Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            height: 2.5,
            width: 50.0,
            color: Colors.green),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.0),
        ),
        Row(
          children: <Widget>[Expanded(child: _reitValue(value: '0.00'))],
        )
      ]),
    );

    final reitCard = Container(
      child: reitCardContent,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: () => Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => DetailReit(widget.reitFavorite.ticker),
          )),
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 24.0,
        ),
        child: reitCard,
      ),
    );
  }
}
