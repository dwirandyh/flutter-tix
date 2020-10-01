part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;

  SignUpPage(this.registrationData);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;

    passwordController.text = "";
    confirmController.text = "";
  }

  void registerData() {
    String errorMessage = "";
    if (!(nameController.text.trim() != "" &&
        emailController.text.trim() != "" &&
        passwordController.text.trim() != "" &&
        confirmController.text.trim() != "")) {
      errorMessage = "Please fill all the fields";
    } else {
      if (passwordController.text.length < 6) {
        errorMessage = "Password's length min 6 characters";
      } else if (passwordController.text.trim() !=
          confirmController.text.trim()) {
        errorMessage = "Mismatch password and confirmed password";
      } else if (!EmailValidator.validate(emailController.text.trim())) {
        errorMessage = "Wrong formatted email address";
      }
    }

    if (errorMessage.isNotEmpty) {
      Flushbar(
              duration: Duration(milliseconds: 1500),
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: Color(0xFFFF5C83),
              message: errorMessage)
          .show(context);
    } else {
      widget.registrationData.name = nameController.text;
      widget.registrationData.email = emailController.text;
      widget.registrationData.password = passwordController.text;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreferencePage(widget.registrationData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: Colors.grey)));

    return Scaffold(
        body: Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              NavigationBar("Registration Page"),
              profileImage(),
              SizedBox(
                height: 36,
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Full Name",
                    hintText: "Full Name"),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Email",
                    hintText: "Email"),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Password",
                    hintText: "Password"),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: confirmController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Confirm Password",
                    hintText: "Confirm Password"),
              ),
              SizedBox(
                height: 30,
              ),
              FloatingActionButton(
                  child: Icon(Icons.arrow_forward),
                  backgroundColor: mainColor,
                  elevation: 0,
                  onPressed: this.registerData)
            ],
          )
        ],
      ),
    ));
  }

  Widget profileImage() => Container(
        width: 90,
        height: 104,
        child: Stack(
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: (widget.registrationData.profileImage == null
                          ? AssetImage("assets/user_pic.png")
                          : FileImage(widget.registrationData.profileImage)),
                      fit: BoxFit.cover)),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () async {
                  if (widget.registrationData.profileImage == null) {
                    widget.registrationData.profileImage = await getImage();
                  } else {
                    widget.registrationData.profileImage = null;
                  }

                  setState(() {});
                },
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                          (widget.registrationData.profileImage == null)
                              ? "assets/btn_add_photo.png"
                              : "assets/btn_del_photo.png"),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
