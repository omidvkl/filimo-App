import 'package:filimo_app/config/app_setting.dart';
import 'package:filimo_app/screens/authentication/login/login_page.dart';
import 'package:filimo_app/screens/authentication/register/register_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool isLogged = false;
  AppSetting appSetting = AppSetting();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff222220),

      body: Container(

          child: FutureBuilder<bool>(future: appSetting.isUserLogged(),builder: (context,snapshot){

            if (snapshot.hasData){

              if(snapshot.data==true){
               isLogged = true;
              }

              return userStatues();
            }else {
              return CircularProgressIndicator();
            }
          }),

      ),
    );
  }

  Widget userStatues() {

    if(isLogged) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<String>(future: appSetting.getName(),builder: (context,snapshot){

              if (snapshot.hasData){
                return Text('${snapshot.data}',style: TextStyle(color: Colors.white),);
              }else {
                return Text('');
              }
            }),
            FutureBuilder<String>(future: appSetting.getEmail(),builder: (context,snapshot){

              if (snapshot.hasData){
                return Text('${snapshot.data}',style: TextStyle(color: Colors.white),);
              }else {
                return Text('');
              }
            }),
          ],
        ),
      );
    }else {
      return Container(

         child:  Center(

           child: Container(
             width: 260,
             height: 120,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(8),
               color: Colors.amber[400],
             ),

             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,

               children: [
                 Text('شما هنوز وارد پروفایل کاربری نشده اید'),
                 SizedBox(height: 8,),

                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     ElevatedButton(onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                     }, child: Text('عضویت'), style: ElevatedButton.styleFrom(
                       backgroundColor: Color(0xffc0392b),
                     )),
                     SizedBox(width: 8),
                     ElevatedButton(onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                     }, child: Text('ورود'),style: ElevatedButton.styleFrom(
                       backgroundColor: Color(0xffc0392b))),
                   ],
                 ),
               ],
             )
           ),
         ),
       );

  }

  }
}
