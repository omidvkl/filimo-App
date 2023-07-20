import 'package:chewie/chewie.dart';
import 'package:filimo_app/api/api_caller.dart';
import 'package:filimo_app/config/app_setting.dart';
import 'package:filimo_app/models/status_model.dart';
import 'package:filimo_app/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:video_player/video_player.dart';

import '../../models/video_detail_model.dart';

class PlayerPage extends StatefulWidget {
  final VideoModel Video;

  const PlayerPage({Key? key, required this.Video}) : super(key: key);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  ApiCaller apiCaller = ApiCaller();
  late Future<VideoDetailModel> videoDetail;
  String comment = '';
  AppSetting appSetting  = AppSetting();
  String userName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController =
        VideoPlayerController.network('${widget.Video.videoUrl}');

    getUserId();
  }

  getUserId()async{
    userName = await appSetting.getName();
  }

  Future<bool> loadVideoPlayer() async {
    await videoPlayerController.initialize();
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: true);
    return true;  }

  @override
  Widget build(BuildContext context) {
    videoDetail = apiCaller.getSingleVideoURL(widget.Video.id!);

    return Scaffold(
      backgroundColor: Color(0xff222220),
      appBar: AppBar(
        title: Text('${widget.Video.videTitle}'),
        backgroundColor: Color(0xff222220),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<VideoDetailModel>(
                future: videoDetail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          FutureBuilder<bool>(
                              future: loadVideoPlayer(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                      margin: EdgeInsets.only(
                                          top: 16, right: 8, left: 8),
                                      height: 220,
                                      child:
                                      Chewie(controller: chewieController));
                                } else {
                                  return CircularProgressIndicator();
                                }
                              }),
                          Container(
                            //margin: EdgeInsets.only(right: 8, left: 8),
                            width: MediaQuery.of(context).size.width,
                            child: Html(
                              data: widget.Video.videoDescription,
                              style: {
                                'P': Style(
                                  color: Colors.amber,
                                  textAlign: TextAlign.justify,
                                  letterSpacing: 1.3,
                                ),
                                'direction': Style(direction: TextDirection.rtl),
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 400,


                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.userCommentsList!.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {

                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,

                                    child: Row(
                                      children: [

                                        Text('${snapshot.data!.userCommentsList![index].userName}',
                                            style: TextStyle(color: Colors.white)),
                                        SizedBox(width: 10,),
                                        Text('${snapshot.data!.userCommentsList![index].commentText}',
                                            style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  );
                                }),
                          ),

                          Container(
                            height: 50,
                            padding: EdgeInsets.only(right: 10,left: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                gradient: LinearGradient(colors: [
                                  Colors.amberAccent,
                                  Colors.redAccent,
                                ])
                            ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(flex: 4,child: TextField(
                                  onChanged: (value) {
                                    comment = value;
                                  },
                                  decoration: InputDecoration(
                                     // border: OutlineInputBorder(),
                                      hintText: 'Add Comment'
                                  ),
                                ),),
                                Expanded(flex: 1,child: IconButton(onPressed: ()async{

                                 StatusModel statusModel = await apiCaller.addComment(comment, userName, widget.Video.id!);

                                  
                                }, icon: Icon(Icons.send_rounded),)),

                              ],
                            )
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: TextStyle(color: Colors.white),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }
}