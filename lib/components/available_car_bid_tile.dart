import 'package:flutter/material.dart';

class AvailableCarTile extends StatefulWidget {
  AvailableCarTile({Key? key}) : super(key: key);

  @override
  _AvailableCarTileState createState() => _AvailableCarTileState();
}

class _AvailableCarTileState extends State<AvailableCarTile> {
  String text = '';
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
                  width: 100.0,
                  height: 110.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGNhcnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'))),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  width: MediaQuery.of(context).size.width - 110.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            color: Colors.orange[100],
                            child: Text(
                              "Car Service",
                              style: TextStyle(
                                  fontSize: 8.0, color: Colors.orange[900]),
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
                        'Car for 4 People',
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'I need a car service for 4 people from delhi to roorkee on 24th october',
                        style: TextStyle(fontSize: 10.0, color: Colors.black54),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Colors.grey[200]!,
                        ),
                        child: DropdownButton(
                            isExpanded: true,
                            isDense: true,
                            underline: SizedBox(),
                            value: "Maruti Alto",
                            onChanged: (value) => {print(value)},
                            items: [
                              DropdownMenuItem(
                                onTap: () => {},
                                child: Text(
                                  "Swift Dzire",
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                value: 'Swift Dzire',
                              ),
                              DropdownMenuItem(
                                onTap: () => {},
                                child: Text(
                                  "Maruti Alto",
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                value: 'Maruti Alto',
                              ),
                            ]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 240.0,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  text = value;
                                });
                              },
                              style: TextStyle(fontSize: 12.0),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(10.0),
                                  filled: true,
                                  prefixText: "₹ ",
                                  labelText: "Offer Price",
                                  hintText: "100",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.teal[50]!,
                                          style: BorderStyle.solid,
                                          width: 1.0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.green,
                                          style: BorderStyle.solid,
                                          width: 1.0))),
                            ),
                          ),
                          SizedBox(
                              width: 100.0,
                              height: 35.0,
                              child: ElevatedButton(
                                  onPressed: () => {},
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      primary: text != ''
                                          ? Colors.teal[800]
                                          : Colors.grey[50]),
                                  child: Text(
                                    "Send Quote",
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: text != ''
                                            ? Colors.white
                                            : Colors.black54),
                                  ))),
                        ],
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
