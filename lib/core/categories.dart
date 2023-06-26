// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:f21_demo/core/assets.dart';

class Category {
  final String name;
  final String description;
  final int id;
  final String photoPath;
  Category({required this.name, required this.id, required this.description, required this.photoPath});
}

class Categories {
  static final List<Category> _categories = [
    Category(
        name: 'Gebelik',
        id: 1,
        description:
            "Gebelik dönemiyle ilgili sorularınızı paylaşabilir, deneyimlerinizi paylaşabilir ve gebelikle ilgili bilgileri edinebilirsiniz.",
        photoPath: Assets.exampleForumBannerPath),
    Category(
        name: "Doğum",
        id: 2,
        description:
            "Doğum deneyimlerinizi paylaşabilir, doğum öncesi hazırlıklar hakkında bilgi alabilir ve diğer annelerle doğum konusunda destek alışverişi yapabilirsiniz.",
        photoPath: Assets.exampleForumBannerPath),
    Category(
        name: 'Annelik',
        id: 3,
        description: "Anneler arasında dayanışma, deneyim paylaşımı ve anne-bebek ilişkisi hakkında konuşma platformu.",
        photoPath: Assets.exampleForumBannerPath),
    Category(
        name: 'Beslenme',
        id: 4,
        description:
            "Bebek ve anne beslenmesi, emzirme, katı gıdalara geçiş ve sağlıklı beslenmeyle ilgili konuları paylaşabilir ve bilgi alabilirsiniz.",
        photoPath: Assets.exampleForumBannerPath),
    Category(
        name: 'Sağlık',
        id: 5,
        description:
            "Anne ve bebek sağlığı, bakımı, hastalıklar, aşılar ve genel sağlık konuları hakkında bilgi paylaşımı ve destek alışverişi yapabilirsiniz.",
        photoPath: Assets.exampleForumBannerPath),
    Category(
        name: 'Psikoloji',
        id: 6,
        description:
            "Anne psikolojisi, doğum sonrası duygusal değişimler, stres yönetimi, ebeveynlik zorlukları ve psikolojik destek konularında tartışma ve paylaşım platformu",
        photoPath: Assets.exampleForumBannerPath),
  ];

  static final Map<int, Category> _categoriesById = {
    for (var category in _categories) category.id: category,
  };

  static String getCategoryNameById(int id) {
    Category? category = _categoriesById[id];
    return category?.name ?? 'Unknown Category';
  }

  static List<Category> get all => _categories;
}
