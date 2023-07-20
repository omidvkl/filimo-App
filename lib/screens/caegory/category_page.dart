import 'package:cached_network_image/cached_network_image.dart';
import 'package:filimo_app/api/api_caller.dart';
import 'package:filimo_app/models/category_model.dart';
import 'package:filimo_app/screens/categoryvideos/category_videos_page.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Future<List<CategoryModel>> categoryList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryList = ApiCaller().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff222220),
      body: Container(
        child: FutureBuilder<List<CategoryModel>>(
            future: categoryList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoryVideosPage(
                                          category: snapshot.data![index],
                                        )));
                          },
                          child: Container(
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      '${snapshot.data![index].categoryImage}',
                                  height: 170,
                                  fit: BoxFit.fill,
                                ),
                                Text(
                                  '${snapshot.data![index].categoryName}',
                                  style: TextStyle(color: Colors.amber),
                                )
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
