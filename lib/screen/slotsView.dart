import 'package:flutter/material.dart';
class SlotView extends StatefulWidget {
  @override
  _SlotViewState createState() => _SlotViewState();
}

class _SlotViewState extends State<SlotView> {
  var a=[0,0,1,1,1,1,0,1,0,1];
  double right =0.0;
  double left = 0.0;
  int select = -1;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Slots View"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(a.length, (index){
          if(index%2==0)
          {
            setState(() {
              right =20;
              left = 0;
            });
          }
          else{
            setState(() {
              right =0;
              left = 50;
            });
          }
          if(a[index]==1)
            {
              return GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(left:left ,right:right ) ,
                  child:gettile(index, select),
                ),
              );
            }
          else
            {

              return GestureDetector(
                onTap: (){
                  setState(() {
                    select = index;
                  });
                },
                child: Padding(
                  padding:  EdgeInsets.only(left:left ,right:right ),
                  child:gettile(index,select),
                ),
              );
            }

        }),
      ),
    );
  }
  Widget gettile(int index,int select){
  bool isSelected = index == select ;
  bool isbooked = a[index] == 1;
    return Container(
        child:isbooked ? Icon(Icons.car_rental,size: 90,) :Icon(Icons.local_parking_outlined,size: 90,),

        padding: EdgeInsets.all(40),
        decoration: BoxDecoration(
            color: isSelected ? Colors.red : Colors.blue,
            border: Border(top: BorderSide(width: 3,color: Colors.black,style: BorderStyle.solid),
              bottom: BorderSide(width: 9,color: Colors.black,style: BorderStyle.solid),
            )
        )
    );
  }


}
