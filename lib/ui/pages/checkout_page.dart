part of 'pages.dart';

class CheckoutPage extends StatefulWidget {
  final Ticket ticket;

  CheckoutPage(this.ticket);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int get total => 26500 * widget.ticket.seats.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: accentColor1),
          SafeArea(
            child: Container(color: Colors.white),
          ),
          ListView(
            children: [
              Stack(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, left: defaultMargin),
                        padding: EdgeInsets.all(1),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (_, userState) {
                      return Column(
                        children: [
                          // note: PAGE TITLE
                          titleSection(),
                          // note: MOVIE DESCRIPTION
                          movieSection(),
                          // note: SEPARATOR
                          separator(),
                          // note: ORDER DETAIL
                          orderDetail(),
                          // note: SEPARATOR
                          separator(),
                          // note: WALLET
                          walletSection((userState as UserLoaded).user.balance),
                          // note: CHECKOUT
                          checkoutSection(
                              (userState as UserLoaded).user.balance)
                        ],
                      );
                    },
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget titleSection() => Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Text(
          "Chekcout\nMovie",
          style: blackTextFont.copyWith(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      );

  Widget movieSection() => Row(
        children: <Widget>[
          Container(
            width: 70,
            height: 90,
            margin: EdgeInsets.only(left: defaultMargin, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(
                  imageBaseURL + "w342" + widget.ticket.movieDetail.posterPath,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width -
                    2 * defaultMargin -
                    70 -
                    20,
                child: Text(
                  widget.ticket.movieDetail.title,
                  style: blackTextFont.copyWith(fontSize: 18),
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width -
                    2 * defaultMargin -
                    70 -
                    20,
                margin: EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  widget.ticket.movieDetail.genresAndLanguage,
                  style: greyTextFont.copyWith(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
              RatingStars(
                voteAverage: widget.ticket.movieDetail.voteAverage,
                color: accentColor3,
              )
            ],
          )
        ],
      );

  Widget separator() => Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: defaultMargin),
        child: Divider(
          color: Color(0xFFE4E4E4),
          thickness: 1,
        ),
      );

  Widget orderDetail() => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order ID",
                  style: greyTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Text(
                  widget.ticket.bookingCode,
                  style: whiteNumberFont.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          SizedBox(height: 9),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cinema",
                  style: greyTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Text(
                    widget.ticket.theater.name,
                    textAlign: TextAlign.end,
                    style: whiteNumberFont.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 9),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Date & Time",
                  style: greyTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Text(
                  widget.ticket.time.dayAndTime,
                  style: whiteNumberFont.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          SizedBox(height: 9),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Seat Numbers",
                  style: greyTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Text(
                    widget.ticket.seatsInString,
                    textAlign: TextAlign.end,
                    style: whiteNumberFont.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 9),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Price",
                  style: greyTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Text(
                  "IDR 25.000 x ${widget.ticket.seats.length}",
                  textAlign: TextAlign.end,
                  style: whiteNumberFont.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          SizedBox(height: 9),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Fee",
                  style: greyTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Text(
                  "IDR 1.500 x ${widget.ticket.seats.length}",
                  textAlign: TextAlign.end,
                  style: whiteNumberFont.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          SizedBox(height: 9),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: greyTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Text(
                  NumberFormat.currency(
                    locale: 'id_ID',
                    decimalDigits: 0,
                    symbol: 'IDR ',
                  ).format(total),
                  textAlign: TextAlign.end,
                  style: whiteNumberFont.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      );

  Widget walletSection(int balance) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Your Wallet",
              style: greyTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Text(
              NumberFormat.currency(
                locale: 'id_ID',
                decimalDigits: 0,
                symbol: 'IDR ',
              ).format(balance),
              textAlign: TextAlign.end,
              style: whiteNumberFont.copyWith(
                  color:
                      balance >= total ? Color(0xFF3E9D9D) : Color(0xFFFF5C83),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );

  Widget checkoutSection(int balance) => Container(
        width: 250,
        height: 46,
        margin: EdgeInsets.only(top: 36, bottom: 50),
        child: RaisedButton(
            elevation: 0,
            color: balance >= total ? Color(0xFF3E9D9D) : mainColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Text(
              balance >= total ? "Checkout Now" : "Top Up My Wallet",
              style: whiteTextFont.copyWith(fontSize: 16),
            ),
            onPressed: () {
              if (balance >= total) {
              } else {}
            }),
      );
}
