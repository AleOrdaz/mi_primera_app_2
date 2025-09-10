import 'package:flutter/material.dart';
import 'package:app89/constantes.dart' as cons;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2, //100%
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: InkWell(
                    child: Container(
                      color: cons.azulito,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: InkWell(
                    child: Container(
                      color: cons.azulito3,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: InkWell(
                    child: Container(
                      color: cons.azulito2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2, //100%
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(),
                ),
                Expanded(
                  flex: 4,
                  child: Container(),
                ),
                Expanded(
                  flex: 4,
                  child: Container(),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2, //100%
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: InkWell(
                    child: Container(
                      color: cons.azulito,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: InkWell(
                    child: Container(
                      color: cons.azulito3,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: InkWell(
                    child: Container(
                      color: cons.azulito2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2, //100%
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(),
                ),
                Expanded(
                  flex: 4,
                  child: Container(),
                ),
                Expanded(
                  flex: 4,
                  child: Container(),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2, //100%
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: InkWell(
                    child: Container(
                      color: cons.azulito,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: InkWell(
                    child: Container(
                      color: cons.azulito3,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: InkWell(
                    child: Container(
                      color: cons.azulito2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2, //100%
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(),
                ),
                Expanded(
                  flex: 4,
                  child: Container(),
                ),
                Expanded(
                  flex: 4,
                  child: Container(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
