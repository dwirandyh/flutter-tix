part of 'services.dart';

class TicketServices {
  static CollectionReference ticketCollection =
      FirebaseFirestore.instance.collection("tickets");

  static Future<void> saveTicket(String id, Ticket ticket) async {
    await ticketCollection.doc().set({
      "movieID": ticket.movieDetail.id ?? "",
      "userID": id ?? "",
      "theaterName": ticket.theater.name ?? 0,
      "time": ticket.time.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
      "bookingCode": ticket.bookingCode,
      "seats": ticket.seatsInString,
      "name": ticket.name,
      "totalPrice": ticket.totalPrice
    });
  }

  static Future<List<Ticket>> getTickets(String userId) async {
    QuerySnapshot snapshot = await ticketCollection.get();
    var documents =
        snapshot.docs.where((document) => document.data()["userID"] == userId);
    List<Ticket> tickets = [];

    documents.forEach((document) async {
      MovieDetail movieDetail =
          await MovieServices.getDetails(document.data()["movieID"]);
      tickets.add(Ticket(
          movieDetail: movieDetail,
          theater: Theater(document.data()["theaterName"]),
          time: DateTime.fromMillisecondsSinceEpoch(document.data()["time"]),
          bookingCode: document.data()["bookingCode"],
          seats: document.data()["seats"].toString().split(','),
          name: document.data()["name"],
          totalPrice: document.data()["totalPrice"]));
    });

    return tickets;
  }
}
