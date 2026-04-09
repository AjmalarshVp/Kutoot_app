import '../../../../core/network/mock_api_client.dart';
import '../models/ad_banner_model.dart';
import '../models/category_model.dart';
import '../models/reward_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<AdBannerModel>> getAdBanners();
  Future<List<RewardModel>> getWeeklyRewards();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final MockApiClient client;
  HomeRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CategoryModel>> getCategories() {
    return client.get<List<CategoryModel>>(
      '/categories',
      latency: const Duration(milliseconds: 250),
      body: () => const [
        {
          'id': 'all',
          'name': 'All',
          'icon_key': 'all',
          'color_value': 0xFFE15A78,
        },
        {
          'id': 'fashion',
          'name': 'Fashion',
          'icon_key': 'fashion',
          'color_value': 0xFFC8102E,
        },
        {
          'id': 'electronics',
          'name': 'Electronics',
          'icon_key': 'electronics',
          'color_value': 0xFFEE7B30,
        },
        {
          'id': 'home',
          'name': 'Home',
          'icon_key': 'home',
          'color_value': 0xFFFFC107,
        },
        {
          'id': 'beauty',
          'name': 'Beauty',
          'icon_key': 'beauty',
          'color_value': 0xFF1A1A1A,
        },
        {
          'id': 'grocery',
          'name': 'Grocery',
          'icon_key': 'grocery',
          'color_value': 0xFF2E7D32,
        },
      ].map(CategoryModel.fromJson).toList(),
    );
  }

  @override
  Future<List<AdBannerModel>> getAdBanners() {
    return client.get<List<AdBannerModel>>(
      '/banners',
      latency: const Duration(milliseconds: 300),
      body: () => const [
        {
          'id': 'b1',
          'title': 'Fashion Fiesta',
          'subtitle': 'Up to 70% off',
          'image_url':
              'https://imgs.search.brave.com/cbas-BUv7MDwoyWdv51o4C1DVvXiYEQdyAQWYgXLrOY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTQ3/MTk5MDkyOS92ZWN0/b3Ivc3BlY2lhbC1v/ZmZlci1iYW5uZXIt/bWVnYS1zYWxlLW9m/Zi1zdG9yZS1wb3N0/ZXItc3RpY2tlci12/ZWN0b3IuanBnP3M9/NjEyeDYxMiZ3PTAm/az0yMCZjPU9IOHM1/LW5hUVpxZmZsN3Qx/MXNuWHhVQlZOY1Nx/TUZqa3ItYjhvSUNz/Qkk9',
          'cta_label': 'Shop Now',
        },
        {
          'id': 'b2',
          'title': 'Electronics Carnival',
          'subtitle': 'Mega deals on latest gadgets',
          'image_url':
              'https://images.unsplash.com/photo-1518770660439-4636190af475?w=900',
          'cta_label': 'Explore',
        },
        {
          'id': 'b3',
          'title': 'Beauty Bonanza',
          'subtitle': 'Flat ₹500 cashback on Nykaa',
          'image_url':
              'https://images.unsplash.com/photo-1522335789203-aaa687d6d18d?w=900',
          'cta_label': 'Grab Offer',
        },
      ].map(AdBannerModel.fromJson).toList(),
    );
  }

  @override
  Future<List<RewardModel>> getWeeklyRewards() {
    return client.get<List<RewardModel>>(
      '/rewards',
      latency: const Duration(milliseconds: 350),
      body: () => const [
        {
          'id': 'r1',
          'title': '3Cr Luxury Villa',
          'total_value_label': 'TOTAL VALUE ₹3,00,00,000',
          'image_url':
              'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=900',
          'progress': 0.7,
          'tag': 'primary',
        },
        {
          'id': 'r2',
          'title': 'The 2024 Supercar',
          'total_value_label': 'TOTAL VALUE ₹1,80,00,000',
          'image_url':
              'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=900',
          'progress': 0.4,
          'tag': 'eligible',
        },
        {
          'id': 'r3',
          'title': 'Goa Getaway',
          'total_value_label': 'TOTAL VALUE ₹2,50,000',
          'image_url':
              'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=900',
          'progress': 0.9,
          'tag': 'eligible',
        },
      ].map(RewardModel.fromJson).toList(),
    );
  }
}
