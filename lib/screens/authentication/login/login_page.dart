import 'package:filimo_app/api/api_caller.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //backgroundColor: Color(0xff222220),
      appBar: AppBar(
        title: Text('ورود در فیلیمو'),
        backgroundColor: Color(0xff222220),
        centerTitle: true,
      ),

      body: Container(
        margin: EdgeInsets.only(left: 16,right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'ایمیل',
              ),
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(height: 10),

            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'پسورد',
              ),
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                password = value;
              },
            ),
            SizedBox(height: 10),
            
            Container(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {

                ApiCaller().Login(email, password).then((value) {

                  if (value.success=='1'){

                    SnackBar snackBar = SnackBar(content: Text('شما با موفقیت وارد  شدید',style: TextStyle(color: Colors.black)),
                    backgroundColor: Colors.amber,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  }else {
                    SnackBar snackBar = SnackBar(content: Text('این کاربر وجود ندارد',style: TextStyle(color: Colors.black)),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  }
                });

              }, child: Text('ورود به فیلیمو')),
            )
          ],
        ),
      ),


    );
  }
}
