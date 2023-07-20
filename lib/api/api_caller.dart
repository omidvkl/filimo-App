import 'package:filimo_app/api/constants.dart';
import 'package:filimo_app/api/json_convertor.dart';
import 'package:filimo_app/models/banners_model.dart';
import 'package:filimo_app/models/category_model.dart';
import 'package:filimo_app/models/home_model.dart';
import 'package:filimo_app/models/loginstatus.dart';
import 'package:filimo_app/models/status_model.dart';
import 'package:filimo_app/models/video_detail_model.dart';
import 'package:http/http.dart' as http;

import '../models/video_model.dart';

class ApiCaller {
  Future<List<BannerModel>> getBannerList() async {

    var url = Uri.parse(constants.BannersURL);
    var response = await http.get(url);
    List<BannerModel> banners = JsonConvertor.getBanners(response);
    return banners;
  }

  Future<HomeModel> getHomeVideos() async {
    var url = Uri.parse(constants.VideoURL);
    var response = await http.get(url);
    HomeModel homeModel = JsonConvertor.getHomeVideo(response);
    return homeModel;
  }

  Future<List<CategoryModel>>getCategories()async{
    var url = Uri.parse(constants.CategoryURL);
    var response = await http.get(url);
    print(response.statusCode);
    List<CategoryModel> castList = JsonConvertor.getCategories(response);
    return castList;
    
  }

  Future<List<VideoModel>> getVideos(String categoryId)async{
    var url = Uri.parse(constants.VideoCategoryURL+categoryId);
    var response = await http.get(url);
    List<VideoModel> videoList =JsonConvertor.getVideos(response);
    return videoList;


  }
  Future<StatusModel> register(String name , String email , String password, String phone)async{
    var url = Uri.parse('${constants.registerURL}&name=${name}&email=${email}&password=${password}&phone=${phone}');
    var response = await http.get(url);
    print(response.body);
    return JsonConvertor.getRegister(response);

  }

  Future Login(String email , String password) async {
    var url = Uri.parse('${constants.LoginURL}&email=${email}&password=${password}');
    var response = await http.get(url);
    print(response.body);
    return JsonConvertor.getLogin(response);

  }
  Future<VideoDetailModel> getSingleVideoURL(String videoId)async{
    var url = Uri.parse(constants.SingleVideoURL+videoId);
    var response = await http.get(url);
    VideoDetailModel video =JsonConvertor.getSingleVideo(response);
    return video;
  }

  Future<StatusModel> addComment(String commentText,String userName,postId)async{
    var url = Uri.parse(constants.AddCommentURL+'&comment_text=${commentText}&user_name=${userName}&post_id${postId}');
    var response = await http.get(url);

    StatusModel statusModel = JsonConvertor.sendComment(response);
    return statusModel;

  }



}
