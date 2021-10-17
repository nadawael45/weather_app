import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weathercourseapp/controller/api_helper.dart';
import 'package:weathercourseapp/models/weaher_model.dart';
import 'package:weathercourseapp/view/Widgets/customContainer.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  Map<String,String>images= {
    'sn':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXLoupWIPbipGXnaFqSwIxPNInsRXIOOb7hQ&usqp=CAU',
    'sl':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXLoupWIPbipGXnaFqSwIxPNInsRXIOOb7hQ&usqp=CAU',
    'h':'https://c8.alamy.com/comp/MCEDBJ/flakes-and-balls-of-ice-crystals-on-green-grass-after-a-hail-storm-appearing-scenic-in-a-shallow-depth-of-field-landscape-image-MCEDBJ.jpg',
    't':'https://s.w-x.co/util/image/w/gettyimages-1060120946.jpg?crop=16:9&width=480&format=pjpg&auto=webp&quality=60',
    'hr':'https://www.novinite.com/media/images/2020-04/photo_verybig_204200.jpg',
    'ir':'https://www.novinite.com/media/images/2020-04/photo_verybig_204200.jpg',
    's':'https://www.novinite.com/media/images/2020-04/photo_verybig_204200.jpg',

    'hc':'https://s.w-x.co/util/image/w/gettyimages-1060120946.jpg?crop=16:9&width=480&format=pjpg&auto=webp&quality=60'  ,
    'c': 'https://images.theconversation.com/files/18108/original/rffw88nr-1354076846.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1356&h=668&fit=crop'
    ,
    'lc':'https://p0.pikist.com/photos/399/89/sky-light-cloud-weather-mood-landscape-romantic-mystery-light-spreading.jpg',



  };
  getImage(){
    var listt= images.entries.toList();
    for(var i in listt){
      var img;
      if(i.key==list![0].icon){
     setState(() {
        img=i.value;
        print(img);
        print(list![0].icon);
     });
     return img;


      }
     // break;

    }

  }
 List<WeatherModel>?list;
   WeatherModel? weatherModel;
  String? text;
  ApiHelper apiHelper=ApiHelper();
  getWeather(){
      apiHelper.getWeather(text).then((v){
    setState(() {
     // weatherModel=v;
      list=v;
    });
       });
  }
@override
  void initState() {
    super.initState();
    text='cairo';
    getWeather();
  }
  @override
  Widget build(BuildContext context) {
    print(weatherModel!.cityName);
    return Scaffold(
      body:
      SingleChildScrollView(
        child: InkWell(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height ,
            decoration: BoxDecoration(image:
            DecorationImage(image: NetworkImage(
              list==null?
                'https://images.theconversation.com/files/18108/original/rffw88nr-1354076846.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1356&h=668&fit=crop'
               :
              getImage()==null?
              'https://images.theconversation.com/files/18108/original/rffw88nr-1354076846.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1356&h=668&fit=crop'
                  :getImage(),

            ),

                fit: BoxFit.cover,)),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [IconButton(onPressed: (){
                      apiHelper.getLocation().then((v) {
                        setState(() {
                          weatherModel = v;
                        });
                      });
                      print(weatherModel!.temp!);
                      print(weatherModel!.cityName!);

                    },iconSize: 50,
                        icon: Icon(Icons.location_city,),)],),
                  SizedBox(height: MediaQuery.of(context).size.height*0.12,),

                  SvgPicture.network(
                   list==null?
                    'https://www.metaweather.com/static/img/weather/c.svg'
                        :
                    'https://www.metaweather.com/static/img/weather/${list![0].icon!}.svg'
                    ,height: 50,width: 50,),
                  SizedBox(height: 20,),
                  Text(
                                        weatherModel==null?'cityName':
                                        weatherModel!.cityName!,
                    //checkMethod(),
//                    list==null?'cityName':
//                  list![0].cityName!.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
                  SizedBox(height: 20,),
                  Text(checkTemp()
//                    list==null?'Temp':
//                  list![0].temp!.toStringAsFixed(2)

                  ,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
                  SizedBox(height: 20,),

                  Container(
                    height: MediaQuery.of(context).size.height*0.2,
                    width:MediaQuery.of(context).size.width ,
                    child: ListView.builder(
                      itemCount:list==null?1:list!.length ,
                      itemBuilder: (context,index)=>index!=0?
                          CustomContainer(
                          dateTxt:list==null?'Date': list![index].date! ,
                          highTxt:list==null?'High Temp':list![index].hightemp!.toStringAsFixed(1) ,
                          lowTxt:list==null?'Low Temp': list![index].lowtemp!.toStringAsFixed(1) ,
                          icon:   list==null?'https://www.metaweather.com/static/img/weather/c.svg':
                          'https://www.metaweather.com/static/img/weather/${list![index].icon}.svg'
                        ):SizedBox(),
                        scrollDirection: Axis.horizontal,
                    ),
                  ),

                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(right: 25,left: 25),
                    child: TextField(decoration: InputDecoration(hintText: 'Search Here',prefixIcon: Icon(Icons.search)),
                      onSubmitted: (v){
                      setState(() {
                        text=v;
                      });
                      getWeather();
                      print(list);



                      },
                    ),
                  ),

                ],),
              ),
            ),
          ),
        ),
      ),
    );
  }
  checkMethod() {
    if (list! == null) {
      if (weatherModel! == null) {
        return 'cityName';
      } else {
        return weatherModel!.cityName;
      }
    }

    else {
      return list![0].cityName!.toString();
    }
  }
  checkTemp() {
    if (list! == null) {
      if (weatherModel! == null) {
        return 'temp';
      } else {
        return weatherModel!.temp!.toStringAsFixed(2);
      }
    }

    else {
      return list![0].temp!.toStringAsFixed(2);
    }
  }
}
