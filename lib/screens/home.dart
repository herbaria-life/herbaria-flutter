import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../logger.dart';
import '../theme/colors.dart';

final log = getLogger("HomePage");

// HomePage
class HomePage extends StatelessWidget {
  Future<void> logout() async {
    log.d("Button pushed!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // This is handled by the search bar itself.
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          buildFloatingSearchBar(),
        ],
      ),
    );
  }

  Widget buildFloatingSearchBar() {
    List<String> plantNames = ["Plant 1", "Plant 2", "Plant 3"];

    return FloatingSearchBar(
      body: Container(
        margin: const EdgeInsets.only(top: 110.0),
        child: ListView.builder(
            itemCount: plantNames.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 300.0,
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        height: 10.0,
                        color: Colors.black.withOpacity(0.4),
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(plantNames[index],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'BadScript',
                                  fontSize: 48)),
                        ),
                      ),
                      Ink.image(
                        image:
                            NetworkImage('https://placeimg.com/640/480/nature'),
                        fit: BoxFit.fill,
                        child: InkWell(
                          onTap: () => {},
                          splashColor: ThemeColor.green,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
      hint: 'Search a plant...',
      height: 60.0,
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      transition: ExpandingFloatingSearchBarTransition(),
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
