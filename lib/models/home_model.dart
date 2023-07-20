import 'video_model.dart';

class HomeModel {

  List<VideoModel>? featuredVideoList = [];
  List<VideoModel> latestVideoList = [];
  List<VideoModel> allVideoList = [];

  HomeModel(this.featuredVideoList, this.latestVideoList, this.allVideoList);
}