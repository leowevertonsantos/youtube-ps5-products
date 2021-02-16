abstract class Item {}

class Controller extends Item {
  final String imagePath;
  final String title;
  final String description;

  Controller(this.imagePath, this.title, this.description);
}

final controllers = [
  Controller(
    'assets/icons/ps5_black_controller.png',
    'Dual Sense',
    'Officia PS5 controller',
  ),
  Controller(
    'assets/icons/ps5_black_controller.png',
    'Dual Sense',
    'Blue Version',
  ),
];
