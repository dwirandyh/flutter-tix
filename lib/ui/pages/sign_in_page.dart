part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigningIn = false;

  void initTheme() {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));
  }

  void signIn() async {
    setState(() {
      this.isSigningIn = true;
    });

    ServiceResult<User> result = await AuthServices.signIn(
        email: emailController.text, password: passwordController.text);

    if (result.data == null) {
      setState(() {
        isSigningIn = false;
      });
    }

    Flushbar(
      duration: Duration(seconds: 4),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Color(0xFFFF5C83),
      message: result.message,
    ).show(context);
  }

  Future<bool> handleBackAction() {
    context.bloc<PageBloc>().add(GoToSplashPage());
  }

  @override
  Widget build(BuildContext context) {
    initTheme();

    return WillPopScope(
      onWillPop: this.handleBackAction,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30),
                  SizedBox(
                    height: 70,
                    child: Image.asset("assets/logo.png"),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 70, bottom: 40),
                    child: Text(
                      "Welcome Back,\nExplorer",
                      style: blackTextFont.copyWith(fontSize: 20),
                    ),
                  ),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        this.isEmailValid = EmailValidator.validate(text);
                      });
                    },
                    controller: this.emailController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Email Address",
                        hintText: "Email Address"),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isPasswordValid = text.length > 5;
                      });
                    },
                    controller: this.passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Password",
                        hintText: "Password"),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: <Widget>[
                      Text(
                        "Forgot Password? ",
                        style: greyTextFont.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      Text("Get Now",
                          style: purpleTextFont.copyWith(fontSize: 12))
                    ],
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 40, bottom: 30),
                      child: isSigningIn
                          ? SpinKitFadingCircle(
                              color: mainColor,
                            )
                          : FloatingActionButton(
                              elevation: 0,
                              backgroundColor:
                                  this.isEmailValid && isPasswordValid
                                      ? mainColor
                                      : Color(0xFFE4E4E4),
                              child: Icon(
                                Icons.arrow_forward,
                                color: this.isEmailValid && isPasswordValid
                                    ? Colors.white
                                    : Color(0xFFBEBEBE),
                              ),
                              onPressed:
                                  this.isEmailValid && this.isPasswordValid
                                      ? signIn
                                      : null,
                            ),
                    ),
                  ),
                  Row(children: <Widget>[
                    Text(
                      "Start Fresh Now? ",
                      style: greyTextFont.copyWith(fontWeight: FontWeight.w400),
                    ),
                    Text("Sign Up", style: purpleTextFont)
                  ])
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
