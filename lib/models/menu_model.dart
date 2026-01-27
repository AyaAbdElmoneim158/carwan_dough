import 'package:carwan_dough/models/menu_item_model.dart';
import 'package:carwan_dough/utils/helper/function_helper.dart';

class MenuModel {
  final String id;
  final String name;
  final List<String> images;
  final List<MenuItemModel> menuItems;

  const MenuModel({
    required this.id,
    required this.name,
    required this.images,
    required this.menuItems,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'images': images,
      'menuItems': menuItems.map((e) => e.toMap()).toList(),
    };
  }

  factory MenuModel.fromMap(Map<String, dynamic> map) {
    return MenuModel(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      images: List<String>.from(
        (map['images'] as List<dynamic>? ?? []).map((e) => e.toString()),
      ),
      menuItems: List<MenuItemModel>.from(
        (map['menuItems'] as List<dynamic>? ?? []).map((e) => MenuItemModel.fromMap(e as Map<String, dynamic>)),
      ),
    );
  }

  static final List<MenuModel> menu = [
    MenuModel(
      id: generateId(), //Todo: add id
      name: 'custom orders',
      images: [
        'assets/images/products/30_whatsapp_image_2025-12-29_at_12.07.10_am.webp',
        'assets/images/products/150cb7dc-e484-499c-81c4-402b1df8d39b_1760380946080.webp',
        'assets/images/products/d548c686-5f8d-46c4-8d06-bde90818ea56_1760283286646__1_.webp',
      ],
      menuItems: [
        MenuItemModel(
          id: generateId(),
          name: 'donut tower',
          image: 'assets/images/products/30_whatsapp_image_2025-12-29_at_12.07.10_am.webp',
          price: 2400,
        ),
        MenuItemModel(
          id: generateId(),
          name: 'small donuts tower',
          image: 'assets/images/products/d548c686-5f8d-46c4-8d06-bde90818ea56_1760283286646__1_.webp',
          price: 1500,
        ),
        MenuItemModel(
          id: generateId(),
          name: 'say it with donuts',
          image: 'assets/images/products/150cb7dc-e484-499c-81c4-402b1df8d39b_1760380946080.webp',
          price: 80,
        ),
      ],
    ),
    MenuModel(
      id: generateId(),
      name: 'share boxes',
      images: [
        'assets/images/products/f774899f-f584-468e-add8-6e61b2d976f7_1760387470877.jpg',
      ],
      menuItems: [
        MenuItemModel(
          id: generateId(),
          name: 'All minis - 16 pie',
          image: 'assets/images/products/f774899f-f584-468e-add8-6e61b2d976f7_1760387470877.jpg',
          price: 480,
        ), //E£: font.family> Courier New', Courier, monospace
      ],
    ),
    MenuModel(
      id: generateId(),
      name: 'donuts',
      images: [
        'assets/images/products/1-pistachio-royal-sideview.webp',
        'assets/images/products/2-dubious-dough-sideview.webp',
        'assets/images/products/3-oreo-madness-sideview.webp',
        'assets/images/products/4-lotus-bliss-sideview.webp',
        'assets/images/products/5-blueberry-sideview.webp',
        'assets/images/products/6-boston-dream-sideview.webp',
        'assets/images/products/7-nutella-cup-sideview.webp',
        'assets/images/products/8-bueno-rush-sideview.webp',
        'assets/images/products/9-pink-fantasy-sideview.webp',
        'assets/images/products/10-classic-glazed-sideview.webp',
        'assets/images/products/11-strawberry-cup-sideview.webp',
        'assets/images/products/12-tiramisu-bliss-sideview.webp',
      ],
      menuItems: [
        MenuItemModel(
          id: generateId(),
          name: 'pistachio royal',
          image: 'assets/images/products/1-pistachio-royal-sideview.webp',
          price: 80,
        ),
        MenuItemModel(
          id: generateId(),
          name: 'dubious dough',
          image: 'assets/images/products/2-dubious-dough-sideview.webp',
          price: 85,
        ),
        MenuItemModel(
          id: generateId(),
          name: 'oreo-madness',
          image: 'assets/images/products/3-oreo-madness-sideview.webp',
          price: 55,
        ),
        MenuItemModel(
          id: generateId(),
          name: 'lotus-bliss',
          image: 'assets/images/products/4-lotus-bliss-sideview.webp',
          price: 60,
        ),
        MenuItemModel(
          id: generateId(),
          name: 'blue berry',
          image: 'assets/images/products/5-blueberry-sideview.webp',
          price: 55,
        ),
        MenuItemModel(
          id: generateId(),
          name: 'boston cream',
          image: 'assets/images/products/6-boston-dream-sideview.webp',
          price: 60,
        ),
        MenuItemModel(
          id: generateId(),
          name: 'nutella cup',
          image: 'assets/images/products/7-nutella-cup-sideview.webp',
          price: 65,
        ),
        MenuItemModel(
          id: generateId(),
          name: 'bueno-rush',
          image: 'assets/images/products/8-bueno-rush-sideview.webp',
          price: 60,
        ),
        MenuItemModel(
          id: generateId(),
          name: 'pink fantasy',
          image: 'assets/images/products/9-pink-fantasy-sideview.webp',
          price: 40,
        ),
        MenuItemModel(
          id: generateId(),
          name: 'classic glazed',
          image: 'assets/images/products/10-classic-glazed-sideview.webp',
          price: 35,
        ),
        MenuItemModel(
          id: generateId(),
          name: 'strawberry-cup',
          image: 'assets/images/products/11-strawberry-cup-sideview.webp',
          price: 65,
        ),
        MenuItemModel(
          id: generateId(),
          name: 'tiramisu bliss',
          image: 'assets/images/products/12-tiramisu-bliss-sideview.webp',
          price: 55,
        ),
      ],
    ),
    MenuModel(
      id: generateId(),
      name: 'Cinnamon rolls',
      images: [
        'assets/images/products/13-nutella-cinnamon-roll-topview.webp',
        'assets/images/products/14-caramel-cinnamon-roll-topview.webp',
        'assets/images/products/15-cinnamon-cup-sideview.webp',
        'assets/images/products/16-extra-nutella-sideview.webp',
        'assets/images/products/17-extra-creamy-cheese-sideview.webp',
        'assets/images/products/18-extra-caramel-sideview.webp',
        'assets/images/products/19-extra-walnuts-sideview.webp',
      ],
      menuItems: [
        MenuItemModel(
          id: generateId(),
          name: 'cinnamon cup',
          image: 'assets/images/products/15-cinnamon-cup-sideview.webp',
          price: 120,
        ),
        MenuItemModel(
          id: generateId(),
          name: 'nutella cinnamon roll',
          image: 'assets/images/products/13-nutella-cinnamon-roll-topview.webp',
          price: 80,
        ),
        MenuItemModel(
          id: generateId(),
          name: 'caramel cinnamon roll',
          image: 'assets/images/products/14-caramel-cinnamon-roll-topview.webp',
          price: 80,
        ),
        MenuItemModel(
          id: generateId(),
          name: 'extra creamy cheese',
          image: 'assets/images/products/17-extra-creamy-cheese-sideview.webp',
          price: 20,
        ),
        MenuItemModel(
          id: generateId(),
          name: 'extra nutella',
          image: 'assets/images/products/16-extra-nutella-sideview.webp',
          price: 15,
        ),
        MenuItemModel(
          id: generateId(),
          name: 'extra-caramel',
          image: 'assets/images/products/18-extra-caramel-sideview.webp',
          price: 15,
        ),
        MenuItemModel(
          id: generateId(),
          name: 'extra walnuts',
          image: 'assets/images/products/19-extra-walnuts-sideview.webp',
          price: 20,
        ),
      ],
    ),
  ];
}
