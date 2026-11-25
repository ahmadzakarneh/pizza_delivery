import 'package:flutter/material.dart';

class PizzaModel {
  final String id;
  final String name;
  final String description;
  final double price; // السعر الأساسي للحجم الصغير بالدينار
  final String category;
  final double rating;
  final String prepTime;
  final Color accentColor;

  const PizzaModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.rating,
    required this.prepTime,
    required this.accentColor,
  });

  // جاهز للاستقبال من الباك إند (API) بس يخلصه يوسف
  factory PizzaModel.fromJson(Map<String, dynamic> json) {
    return PizzaModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      category: json['category'] ?? 'الكل',
      rating: (json['rating'] as num?)?.toDouble() ?? 4.5,
      prepTime: json['prep_time'] ?? '20-25 دقيقة',
      accentColor: const Color(0xFFE64A19),
    );
  }
}

// قائمة تجريبية لعرضها في المنيو حالياً
const List<PizzaModel> dummyPizzas = [
  PizzaModel(
    id: '1',
    name: 'بيتزا بيبروني كلاسيك',
    description: 'شرائح بيبروني بقري مدخن مع جبنة موزاريلا ذائبة وصلصة طماطم إيطالية',
    price: 4.50,
    category: 'لحوم',
    rating: 4.9,
    prepTime: '20-25 دقيقة',
    accentColor: Color(0xFFD32F2F),
  ),
  PizzaModel(
    id: '2',
    name: 'بيتزا دجاج باربكيو',
    description: 'قطع صدر دجاج مشوي، صوص الباربكيو المدخن، بصل أحمر، وجبنة موزاريلا',
    price: 5.00,
    category: 'دجاج',
    rating: 4.8,
    prepTime: '25-30 دقيقة',
    accentColor: Color(0xFFE65100),
  ),
  PizzaModel(
    id: '3',
    name: 'بيتزا مارجريتا أصلية',
    description: 'صلصة طماطم طازجة، جبنة موزاريلا مضاعفة، وأوراق ريحان أخضر مع زيت زيتون',
    price: 3.50,
    category: 'نباتي',
    rating: 4.7,
    prepTime: '15-20 دقيقة',
    accentColor: Color(0xFF2E7D32),
  ),
  PizzaModel(
    id: '4',
    name: 'بيتزا سوبريم سوبر',
    description: 'بيبروني، لحم مفروم متبل، فليفلة خضراء، فطر طازج، وزيتون أسود',
    price: 5.50,
    category: 'لحوم',
    rating: 4.9,
    prepTime: '25-30 دقيقة',
    accentColor: Color(0xFFB71C1C),
  ),
  PizzaModel(
    id: '5',
    name: 'بيتزا ألفريدو دجاج',
    description: 'صوص ألفريدو كريمي غني، قطع دجاج مشوية، فطر طازج، ورشة جبنة بارميزان',
    price: 5.25,
    category: 'دجاج',
    rating: 4.8,
    prepTime: '20-25 دقيقة',
    accentColor: Color(0xFFEF6C00),
  ),
  PizzaModel(
    id: '6',
    name: 'بيتزا خضار مشكّلة',
    description: 'فطر طازج، زيتون أسود، ذرة حلوة، فليفلة ملونة، وبصل مع جبنة موزاريلا',
    price: 4.00,
    category: 'نباتي',
    rating: 4.6,
    prepTime: '20-25 دقيقة',
    accentColor: Color(0xFF388E3C),
  ),
];