part of 'widgets.dart';

class NavigationBar extends StatelessWidget {
  final String title;

  NavigationBar(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      height: 56,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              this.title,
              textAlign: TextAlign.center,
              style: blackTextFont.copyWith(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
