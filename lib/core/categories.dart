// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:f21_demo/core/assets.dart';

class Category {
  final String name;
  final String description;
  final int id;
  final String photoPath;
  Category(
      {required this.name,
      required this.id,
      required this.description,
      required this.photoPath});
}

class Categories {
  static final List<Category> _categories = [
    Category(
        name: 'Gebelik',
        id: 1,
        description:
            "Gebelik dönemiyle ilgili sorularınızı, deneyimlerinizi paylaşabilir ve gebelikle ilgili bilgileri edinebilirsiniz.",
        photoPath: Assets.examplePregnantBannerPath),
    Category(
        name: "Doğum",
        id: 2,
        description:
            "Doğum deneyimlerinizi paylaşabilir, diğer annelerle doğum öncesi hazırlıklar hakkında ve doğum konusunda bilgi alışverişi yapabilirsiniz.",
        photoPath: Assets.exampleBirthBannerPath),
    Category(
        name: 'Annelik',
        id: 3,
        description:
            "Anne-bebek ilişkisi hakkında bilgi edinebilir, deneyimli annelerin tecrübesinden faydalanabilir ve anneler arası dayanışmaya katılabilirsiniz.",
        photoPath: Assets.exampleMotherBannerPath),
    Category(
        name: 'Beslenme',
        id: 4,
        description:
            "Bebek ve anne beslenmesi, emzirme, katı gıdalara geçiş ve sağlıklı beslenmeyle ilgili konuları paylaşabilir ve bilgi alabilirsiniz.",
        photoPath: Assets.exampleHealtyNutritionBannerPath),
    Category(
        name: 'Sağlık',
        id: 5,
        description:
            "Anne ve bebek sağlığı, hastalıklar, aşılar ve genel sağlık konuları hakkında bilgi paylaşabilir ve bu konularda daha donanımlı annelerin fikirlerini alabilirsiniz.",
        photoPath: Assets.exampleHealthBannerPath),
    Category(
        name: 'Gelişim',
        id: 6,
        description:
            "Bebeğinizin hangi aylarda nasıl gelişim gösterdiği, fiziksel ve zihinsel değişimi hakkında fikir alışverişi yapabilirsiniz. ",
        photoPath: Assets.examplePsychologyBannerPath),
    Category(
        name: 'Bakım',
        id: 7,
        description:
        "Bebeğinizin akımı ve sizin bakımınız için neler gerekli, hangi bakımlar fayda sağlıyor ve benzeri bilgileri edinebilir, şahsi yorumlarınızı paylaşabilirsiniz.",
        photoPath: Assets.exampleCareBannerPath),
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
