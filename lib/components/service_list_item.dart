import 'package:flutter/material.dart';

class ServiceListItem extends StatefulWidget {
  ServiceListItem({Key? key}) : super(key: key);

  @override
  _ServiceListItemState createState() => _ServiceListItemState();
}

class _ServiceListItemState extends State<ServiceListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1461354464878-ad92f492a5a0?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1470&q=80'))),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  width: MediaQuery.of(context).size.width - 90.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            color: Colors.lightGreen[100],
                            child: Text(
                              "Agriculture",
                              style: TextStyle(
                                  fontSize: 8.0, color: Colors.lightGreen[900]),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 3.0),
                          ),
                          Text(
                            "12 Oct 2021",
                            style:
                                TextStyle(fontSize: 8.0, color: Colors.black54),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Mushroom',
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '5Kg of Mushroom is required in dehradun assa ds',
                        style: TextStyle(fontSize: 10.0, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              height: 20.0,
            )
          ],
        ));
  }
}
