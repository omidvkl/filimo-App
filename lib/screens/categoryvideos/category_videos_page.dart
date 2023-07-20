import 'package:cached_network_image/cached_network_image.dart';
import 'package:filimo_app/api/api_caller.dart';
import 'package:filimo_app/models/category_model.dart';
import 'package:filimo_app/screens/player/player_page.dart';
import 'package:flutter/material.dart';

import '../../models/video_model.dart';

class CategoryVideosPage extends StatefulWidget {
  final CategoryModel category;

  const CategoryVideosPage({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoryVideosPage> createState() => _CategoryVideosPageState();
}

class _CategoryVideosPageState extends State<CategoryVideosPage> {
  late Future<List<VideoModel>> getVideos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getVideos = ApiCaller().getVideos(widget.category.cid!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff222220),
      appBar: AppBar(
        title: Text('${widget.category.categoryName}'),
        backgroundColor: Color(0xff222220),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<List<VideoModel>>(
            future: getVideos,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PlayerPage(
                                        Video: snapshot.data![index])));
                          },
                          child: Container(
                            height: 160,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${snapshot.data![index].videTitle}',
                                  style: TextStyle(color: Colors.amber),
                                ),
                                const SizedBox(width: 16),
                                CachedNetworkImage(
                                  imageUrl:
                                      '${snapshot.data![index].videoThumbnailS}',
                                  width: 200,
                                  height: 140,
                                  fit: BoxFit.fill,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              } else if (snapshot.hasError) {
                return const Text('Error');
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
