part of 'pages.dart';

class AccountConfirmation extends StatefulWidget {
  final RegistrationData registrationData;

  AccountConfirmation(this.registrationData);

  @override
  _AccountConfirmationState createState() => _AccountConfirmationState();
}

class _AccountConfirmationState extends State<AccountConfirmation> {
  bool isSignup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 30),
                child: NavigationBar("Confirm\nNew Account")),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: (widget.registrationData.profileImage == null)
                        ? AssetImage("assets/user_pic.png")
                        : FileImage(widget.registrationData.profileImage),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Welcome",
              style: blackTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w300),
            ),
            Text(
              "${widget.registrationData.name}",
              textAlign: TextAlign.center,
              style: blackTextFont.copyWith(fontSize: 50),
            ),
            SizedBox(height: 110),
            actionButton()
          ],
        ),
      ),
    );
  }

  Widget actionButton() {
    return (isSignup)
        ? SpinKitFadingCircle(color: Color(0xFF3E9D9D))
        : SizedBox(
            width: 250,
            height: 45,
            child: RaisedButton(
              color: Color(0xFF3E9D9D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Create My Account",
                style: whiteTextFont.copyWith(fontSize: 16),
              ),
              onPressed: () async {
                setState(() {
                  isSignup = true;
                });

                ServiceResult<User> result = await AuthServices.signUp(
                    widget.registrationData.email,
                    widget.registrationData.password,
                    widget.registrationData.name,
                    widget.registrationData.selectedGenres,
                    widget.registrationData.selectedLang);

                if (result.data == null) {
                  setState(() {
                    isSignup = false;
                  });

                  Flushbar(
                    duration: Duration(milliseconds: 1500),
                    flushbarPosition: FlushbarPosition.TOP,
                    backgroundColor: Color(0xFFFF5C83),
                    message: result.message,
                  ).show(context);
                }
              },
            ),
          );
  }
}
