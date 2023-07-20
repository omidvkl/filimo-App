import 'package:filimo_app/api/api_caller.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  String name = '';
  String email = '';
  String password = '';
  String phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xff222220),
      appBar: AppBar(
        title: Text('عضویت در فیلیمو'),
        backgroundColor: Color(0xff222220),
        centerTitle: true,
      ),

      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'نام کاربری',
                ),
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                name = value;
              },
            ),
            SizedBox(height: 10),

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
                hintText: 'رمز عبور',),
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                password = value;
              },
            ),
            SizedBox(height: 10),

            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'شماره همراه',
                ),
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                phone = value;
              },
            ),
            SizedBox(height: 10),

            ElevatedButton(onPressed: (){
              ApiCaller().register(name, email, password, phone).then((value) {

                if (value.success=='1'){
                  SnackBar snackBar = SnackBar(content: Text('شما با موفقیت عضو شدید'),
                   backgroundColor: Colors.amber);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }else {
              SnackBar snackBar = SnackBar(content: Text('اطلاعات اشتباه است. مجددا بررسی کنید'),
              backgroundColor: Colors.amber);
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

              });

            }, child: Text('ثبت نام'),),
          ],
        ),
      ),

    );
  }
}
