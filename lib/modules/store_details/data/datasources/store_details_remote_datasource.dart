import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/mock_api_client.dart';
import '../models/store_details_model.dart';

abstract class StoreDetailsRemoteDataSource {
  Future<StoreDetailsModel> fetchStoreDetails(String storeId);
}

class StoreDetailsRemoteDataSourceImpl implements StoreDetailsRemoteDataSource {
  final MockApiClient client;
  StoreDetailsRemoteDataSourceImpl({required this.client});

  static final Map<String, Map<String, dynamic>> _seed = {
    's1': {
      'id': 's1',
      'name': 'Westside',
      'address': 'Linking Rd, Bandra West, Mumbai 400050',
      'distance_km': 1.2,
      'gallery': [
        'https://images.unsplash.com/photo-1567401893414-76b7b1e5a7a5?w=900',
        'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=900',
        'https://images.unsplash.com/photo-1488161628813-04466f872be2?w=900',
      ],
      'contact_number': '+91 22 2640 1234',
      'opening_hours': 'Mon-Sun: 10:00 AM - 10:00 PM',
      'offers': [
        'Flat 20% off on all apparel',
        'Buy 2 get 1 free on accessories',
        'Extra ₹500 cashback via Kutoot',
      ],
      'services': ['Fashion', 'Accessories', 'Footwear', 'Home Decor'],
      'rating': 4.9,
      'rating_count': 1248,
      'latitude': 19.0825,
      'longitude': 72.8811,
    },
    's2': {
      'id': 's2',
      'name': 'Reliance Digital',
      'address': 'Phoenix Mills, Lower Parel, Mumbai 400013',
      'distance_km': 2.1,
      'gallery': [
        'https://images.unsplash.com/photo-1518770660439-4636190af475?w=900',
        'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=900',
      ],
      'contact_number': '+91 22 6610 5678',
      'opening_hours': 'Mon-Sun: 11:00 AM - 9:30 PM',
      'offers': [
        'No-cost EMI on all electronics',
        'Free home delivery above ₹999',
      ],
      'services': ['Electronics', 'Mobiles', 'Laptops', 'Accessories'],
      'rating': 4.5,
      'rating_count': 932,
      'latitude': 19.0750,
      'longitude': 72.8700,
    },
  };

  @override
  Future<StoreDetailsModel> fetchStoreDetails(String storeId) {
    return client.get<StoreDetailsModel>(
      '/stores/$storeId',
      latency: const Duration(milliseconds: 500),
      body: () {
        final json = _seed[storeId] ??
            {
              'id': storeId,
              'name': 'Kutoot Store',
              'address': 'Premium Plaza, Mumbai',
              'distance_km': 0.0,
              'gallery': [
                'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=900',
                'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=900',
              ],
              'contact_number': '+91 22 0000 0000',
              'opening_hours': 'Mon-Sun: 10:00 AM - 10:00 PM',
              'offers': ['Flat 20% off via Kutoot Pay'],
              'services': ['Shopping', 'Returns', 'Gift Cards'],
              'rating': 4.5,
              'rating_count': 200,
              'latitude': 19.0760,
              'longitude': 72.8777,
            };
        try {
          return StoreDetailsModel.fromJson(json);
        } catch (_) {
          throw ServerException('Failed to parse store details');
        }
      },
    );
  }
}
