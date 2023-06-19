import 'package:flutter/material.dart';


class Routespagehere extends StatefulWidget {
  const Routespagehere({Key? key}) : super(key: key);

  @override
  State<Routespagehere> createState() => _RoutespagehereState();
}

class _RoutespagehereState extends State<Routespagehere> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){
                  Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_ios)),

              Text('Routes Pages'),

              IconButton(onPressed: (){}, icon: Icon(Icons.search_rounded)),
            ],
          )
        ],
      ),
      ),
    );
  }
}
