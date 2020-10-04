part of 'pages.dart';

class SelectSchedulePage extends StatefulWidget {
  @override
  _SelectSchedulePageState createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  List<DateTime> dates;
  DateTime selectedDate;
  int selectedTime;
  Theater selectedTheater;
  bool isValid = false;

  @override
  void initState() {
    super.initState();

    dates = List.generate(
      7,
      (index) => DateTime.now().add(Duration(days: index)),
    );

    selectedDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: accentColor1),
          SafeArea(
            child: Container(
              color: Colors.white,
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: NavigationBar(""),
                  ),
                  chooseDate(),
                  chooseTheater(),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topCenter,
                    child: FloatingActionButton(
                      onPressed: () {},
                      elevation: 0,
                      backgroundColor:
                          (isValid) ? mainColor : Color(0xFFE4E4E4),
                      child: Icon(
                        Icons.arrow_forward,
                        color: isValid ? Colors.white : Color(0xFFBEBEBE),
                      ),
                    ),
                  ),
                  SizedBox(height: 50)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget chooseDate() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
            child: Text(
              "Choose Date",
              style: blackTextFont.copyWith(fontSize: 20),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 24),
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dates.length,
              itemBuilder: (_, index) => Container(
                margin: EdgeInsets.only(
                    left: (index == 0) ? defaultMargin : 0,
                    right: (index < dates.length - 1) ? 16 : defaultMargin),
                child: DateCard(
                  date: dates[index],
                  isSelected: selectedDate == dates[index],
                  onTap: () {
                    setState(() {
                      selectedDate = dates[index];
                    });
                  },
                ),
              ),
            ),
          )
        ],
      );

  Column chooseTheater() {
    List<int> schedule = List.generate(7, (index) => 10 + index * 2);
    List<Widget> widgets = [];

    dummyTheaters.forEach((theater) {
      widgets.add(
        Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
          child: Text(
            theater.name,
            style: blackTextFont.copyWith(fontSize: 20),
          ),
        ),
      );

      widgets.add(
        Container(
          height: 50,
          margin: EdgeInsets.only(bottom: 20),
          child: ListView.builder(
            itemCount: schedule.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => Container(
              margin: EdgeInsets.only(
                  left: (index == 0) ? defaultMargin : 0,
                  right: (index < schedule.length - 1) ? 16 : defaultMargin),
              child: SelectableBox(
                onTap: () {
                  setState(() {
                    selectedTheater = theater;
                    selectedTime = schedule[index];
                    isValid = true;
                  });
                },
                text: "${schedule[index]}:00",
                height: 50,
                isSelected: (selectedTheater == theater &&
                    selectedTime == schedule[index]),
                isEnabled: schedule[index] > DateTime.now().hour ||
                    selectedDate.day != DateTime.now().day,
              ),
            ),
          ),
        ),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
