class Event {
  String name;
  String description;
  DateTime eventDate;
  String image;
  String location;
  String organizer;
  num price;

  Event({this.eventDate, this.image, this.location, this.name, this.organizer, this.price, this.description});
}

final List<Event> upcomingEvents = [
  Event(
    name: "The Pretty Reckless",
    eventDate: DateTime.now().add(const Duration(days: 112)),
    image: 'https://picsum.photos/900',
    description: "The pretty reckless is an American rock band from New york city, Formed in 2009. The",
    location: "Fairview Gospel Church",
    organizer: "Westfield Centre",
    price: 30,
  ),
  Event(
    name: "Live Orchestra",
    eventDate: DateTime.now().add(const Duration(days: 33)),
    image: 'https://picsum.photos/901',
    description: "The pretty reckless is an American rock band from New york city, Formed in 2009. The",
    location: "David Geffen Hall",
    organizer: "Westfield Centre",
    price: 30,
  ),
  Event(
    name: "Local Concert",
    eventDate: DateTime.now().add(const Duration(days: 12)),
    image: 'https://picsum.photos/903',
    description: "The pretty reckless is an American rock band from New york city, Formed in 2009. The",
    location: "The Cutting room",
    organizer: "Westfield Centre",
    price: 30,
  ),
];

final List<Event> nearbyEvents = [
  Event(
    name: "The Pretty Reckless",
    eventDate: DateTime.now().add(const Duration(days: 1)),
    image: 'https://picsum.photos/800',
    description: "The pretty reckless is an American rock band from New york city, Formed in 2009. The",
    location: "Fairview Gospel Church",
    organizer: "Westfield Centre",
    price: 30,
  ),
  Event(
    name: "New Thread Quartet",
    eventDate: DateTime.now().add(const Duration(days: 4)),
    image: 'https://picsum.photos/802',
    description: "The pretty reckless is an American rock band from New york city, Formed in 2009. The",
    location: "David Geffen Hall",
    organizer: "Westfield Centre",
    price: 30,
  ),
  Event(
    name: "Songwriters in Concert",
    eventDate: DateTime.now().add(const Duration(days: 2)),
    image: 'https://picsum.photos/804',
    description: "The pretty reckless is an American rock band from New york city, Formed in 2009. The",
    location: "The Cutting room",
    organizer: "Westfield Centre",
    price: 30,
  ),
  Event(
    name: "Rock Concert",
    eventDate: DateTime.now().add(const Duration(days: 2)),
    image: 'https://picsum.photos/806',
    description: "The pretty reckless is an American rock band from New york city, Formed in 2009. The",
    location: "The Cutting room",
    organizer: "Westfield Centre",
    price: 32,
  ),
  Event(
    name: "Songwriters in Concert",
    eventDate: DateTime.now().add(const Duration(days: 2)),
    image: 'https://picsum.photos/808',
    description: "The pretty reckless is an American rock band from New york city, Formed in 2009. The",
    location: "The Cutting room",
    organizer: "Westfield Centre",
    price: 14,
  ),
];
