import 'item.dart';
import 'order.dart';

class Orders {
  static final List<Order> orders = [
    Order(
      id: 1,
      items: [
        Item(
            imageUrl:
                'https://i5.walmartimages.ca/images/Enlarge/865/709/6000199865709.jpg',
            name:
                "LEGO Disney Pixar’s Toy Story Buzz & Bo Peep’s Playground Adventure 10768 Building Kit (139 Piece)",
            descriptions: [],
            aisle: 12,
            shelfFromBottom: 2,
            leftSide: false,
            orientationDescription: 'Facing the bicycles.',
            shelfFromEnd: 2),
      ],
    ),
  ];
}
