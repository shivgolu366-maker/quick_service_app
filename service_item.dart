class ServiceSubOption {
  final String id;
  final String title;
  final double price;
  final String duration;
  final String description;

  ServiceSubOption({
    required this.id,
    required this.title,
    required this.price,
    required this.duration,
    required this.description,
  });
}

class ServiceItem {
  final String id;
  final String title;
  final String category;
  final String categoryTag;
  final String badgeTitle;
  final String description;
  final double basePrice;
  final String pricingType;
  final int estimatedMinutes;
  final double rating;
  final int reviewsCount;
  final String imageUrl;
  final List<String> includedFeatures;
  final List<ServiceSubOption> subOptions;
  final bool hasChecklist;
  final bool emergencySupported;

  ServiceItem({
    required this.id,
    required this.title,
    required this.category,
    required this.categoryTag,
    required this.badgeTitle,
    required this.description,
    required this.basePrice,
    required this.pricingType,
    required this.estimatedMinutes,
    required this.rating,
    required this.reviewsCount,
    required this.imageUrl,
    required this.includedFeatures,
    required this.subOptions,
    this.hasChecklist = false,
    this.emergencySupported = true,
  });
}