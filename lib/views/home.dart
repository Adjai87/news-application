import 'package:flutter/material.dart';
import 'package:flutter_http_example/wp-api.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

       appBar: AppBar(
        title: Text("Flutter App"),

       ),

       body:Container(child:
        FutureBuilder(
        future: fetchwpPosts(),
         builder: (context, snapshot){
          if(snapshot.hasData){
             
             return ListView.builder(
              itemCount: snapshot.data?.length, 
              itemBuilder: (BuildContext context, int index) {  
                Map wppost = snapshot.data?[index];
                return PostTile(
                  href: wppost['_links']['wp:featuredmedia'][0]['href'],
                  title: wppost['title']['rendered'], 
                  desc: wppost['excerpt']['rendered'], 
                  content: wppost ['content']['rendered'],
                  
                ); 
              },
              );
          }  
          return CircularProgressIndicator();
         }
         
         ),


       ), 

    );
  }
} 

class PostTile extends StatefulWidget {
final String href, title, desc, content;
PostTile({required this.content, required this.desc, required this.href, required this.title,});

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [

       FutureBuilder(
        future: fetchwpPostImageUrl(widget.href), 
        builder: (context, snapshot){
          if(snapshot.hasData){
             return Image.network(snapshot.data['guid']['rendered']);
          }
          return CircularProgressIndicator();
        },
        
        ),

        Text(widget.title),
        Text(widget.desc)
      ], 


    ),
    );
  }
}