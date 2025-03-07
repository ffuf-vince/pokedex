import 'package:flutter/material.dart';
import 'package:pokedex/classes/type_background_color.dart';
import 'package:pokedex/feature/filtered/filtered_page_connector.dart';
import 'package:pokedex/utilities/constants.dart';

class GridOfTypes extends StatelessWidget with TypeBackgroundColor {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      child: GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 5 / 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: List.generate(types.length, (index) {
          return GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FilteredPageConnector(type: types.elementAt(index))),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: getBackgroundColor(type: types.elementAt(index), brightness: Theme.of(context).brightness),
              ),
              child: Center(
                child: Text(
                  types.elementAt(index).toUpperCase(),
                  style: TextStyle(color: Colors.white, shadows: [Shadow(blurRadius: 4, color: Colors.black54)]),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
