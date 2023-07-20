import 'package:cached_network_image/cached_network_image.dart';
import 'package:filimo_app/api/api_caller.dart';
import 'package:filimo_app/models/banners_model.dart';
import 'package:filimo_app/models/home_model.dart';
import 'package:filimo_app/screens/player/player_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiCaller apiCaller = ApiCaller();
  late Future<List<BannerModel>> bannersList;
  late Future<HomeModel> homeModel;

  @override
  Widget build(BuildContext context) {
    bannersList = apiCaller.getBannerList();
    homeModel = apiCaller.getHomeVideos();

    return Scaffold(
      backgroundColor: Color(0xff222220),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              FutureBuilder<List<BannerModel>>(
                  future: bannersList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Widget> imageList = [];
                      for (int i = 0; i < snapshot.data!.length; i++) {
                        String banner = snapshot.data![i].bannerImage!;
                        imageList.add(
                          CachedNetworkImage(
                            imageUrl: '${banner}',
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            height: 170,
                            fit: BoxFit.fill,
                          ),
                        );
                      }

                      return ImageSlideshow(
                        width: double.infinity,
                        height: 200,
                        initialPage: 0,
                        indicatorColor: Colors.blue,
                        indicatorBackgroundColor: Colors.grey,
                        children: imageList,
                        autoPlayInterval: 3000,
                        isLoop: true,
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error');
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
              FutureBuilder<HomeModel>(
                  future: homeModel,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        //height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: Text('آخرین ویدیوها',
                                  style: TextStyle(color: Colors.amber)),
                              margin:
                                  EdgeInsets.only(right: 8, top: 8, bottom: 8),
                            ),
                            Container(
                              height: 200,
                              child: ListView.builder(
                                  itemCount:
                                      snapshot.data!.latestVideoList!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => PlayerPage(
                                                    Video: snapshot.data!
                                                            .latestVideoList![
                                                        index])));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        height: 200,
                                        width: 140,
                                        child: Column(
                                          children: [
                                            //Image.network('${snapshot.data!.latestVideoList![index].videoThumbnailS}',
                                            //height: 170,
                                            //fit: BoxFit.fill,),
                                            CachedNetworkImage(
                                              imageUrl:
                                                  '${snapshot.data!.latestVideoList![index].videoThumbnailS}',
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              height: 170,
                                              fit: BoxFit.fill,
                                            ),
                                            Text(
                                              '${snapshot.data!.featuredVideoList![index].videTitle}',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            Container(
                              child: Text('ویدیوهای ویژه',
                                  style: TextStyle(color: Colors.amber)),
                              margin: EdgeInsets.only(right: 8, bottom: 8),
                            ),
                            Container(
                              height: 200,
                              child: ListView.builder(
                                  itemCount:
                                      snapshot.data!.featuredVideoList!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => PlayerPage(
                                                    Video: snapshot.data!
                                                            .latestVideoList![
                                                        index])));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        height: 200,
                                        width: 140,
                                        child: Column(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  '${snapshot.data!.latestVideoList![index].videoThumbnailS}',
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              height: 170,
                                              fit: BoxFit.fill,
                                            ),
                                            Text(
                                              '${snapshot.data!.featuredVideoList![index].videTitle}',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            Container(
                              child: Text('ویدیوهای تصادفی',
                                  style: TextStyle(color: Colors.amber)),
                              margin: EdgeInsets.only(right: 8, bottom: 8),
                            ),
                            Container(
                              height: 200,
                              child: ListView.builder(
                                  itemCount:
                                      snapshot.data!.featuredVideoList!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => PlayerPage(
                                                    Video: snapshot.data!
                                                            .latestVideoList![
                                                        index])));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        height: 210,
                                        width: 140,
                                        child: Column(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  '${snapshot.data!.latestVideoList![index].videoThumbnailS}',
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              height: 170,
                                              fit: BoxFit.fill,
                                            ),
                                            Text(
                                              '${snapshot.data!.allVideoList![index].videTitle}',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error ${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
