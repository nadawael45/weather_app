import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomContainer extends StatelessWidget {
  String? dateTxt;
  String? icon;
  String? highTxt;
  String? lowTxt;


  CustomContainer({this.dateTxt, this.icon, this.highTxt, this.lowTxt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        height: MediaQuery.of(context).size.height*0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.transparent.withOpacity(0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(dateTxt!,style: txtSt,maxLines: 2,),
            SizedBox(height: 5,),
            SvgPicture.network(icon!,height: 30,width: 30,),
              SizedBox(height: 5,),
              Text('max_temp: '+highTxt!,style: txtSt),
              SizedBox(height: 5,),
              Text('min_temp: '+lowTxt!,style: txtSt),

          ],),
        ),
      ),
    );
  }
}
 const TextStyle txtSt =TextStyle(
   color: Colors.white,fontWeight: FontWeight.bold,
 );
