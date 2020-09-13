part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FireAuth.User firebaseUser = Provider.of<FireAuth.User>(context);

    if (firebaseUser == null) {
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        // Load Data User
        context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));

        prevPageEvent = GoToMainPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    }

    return BlocBuilder<PageBloc, PageState>(builder: (_, pageState) {
      if (pageState is OnSplashPage) {
        return SplashPage();
      } else if (pageState is OnLoginPage) {
        return SignInPage();
      } else if (pageState is OnRegistrationPage) {
        return SignUpPage(pageState.registrationData);
      } else {
        return MainPage();
      }
    });
  }
}
