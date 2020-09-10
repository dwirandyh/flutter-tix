import 'package:flutter/material.dart';
import 'package:flutter_tix/models/models.dart';
import 'package:flutter_tix/services/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                  child: Text("Sign Up"),
                  onPressed: () async {
                    ServiceResult<User> result = await AuthServices.signUp(
                        "dwirandy@gmail.com",
                        "123456",
                        "dwi randy",
                        ["Action", "Horror"],
                        "Korean");

                    if (result.data == null) {
                      print(result.message);
                    } else {
                      print(result.data.toString());
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
