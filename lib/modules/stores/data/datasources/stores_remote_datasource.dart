import '../../../../core/network/mock_api_client.dart';
import '../models/store_model.dart';

abstract class StoresRemoteDataSource {
  Future<List<StoreModel>> fetchNearbyStores({
    required double latitude,
    required double longitude,
    required String categoryId,
    required int page,
    required int pageSize,
  });
}

class StoresRemoteDataSourceImpl implements StoresRemoteDataSource {
  final MockApiClient client;

  StoresRemoteDataSourceImpl({required this.client});

  static const _seedStores = <Map<String, dynamic>>[
    {
      'id': 's1',
      'name': 'Westside',
      'image_url':
          'https://images.unsplash.com/photo-1567401893414-76b7b1e5a7a5?w=600',
      'rating': 4.9,
      'latitude': 19.0825,
      'longitude': 72.8811,
      'offer_label': 'FLAT 20% OFF',
      'category_id': 'fashion',
      'address': 'Linking Rd, Bandra West, Mumbai',
    },
    {
      'id': 's2',
      'name': 'Reliance Digital',
      'image_url':
          'https://images.unsplash.com/photo-1518770660439-4636190af475?w=600',
      'rating': 4.5,
      'latitude': 19.0750,
      'longitude': 72.8700,
      'offer_label': 'FLAT 20% OFF',
      'category_id': 'electronics',
      'address': 'Phoenix Mills, Lower Parel, Mumbai',
    },
    {
      'id': 's3',
      'name': 'Home Centre',
      'image_url':
          'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?w=600',
      'rating': 4.2,
      'latitude': 19.1175,
      'longitude': 72.9060,
      'offer_label': 'FLAT 20% OFF',
      'category_id': 'home',
      'address': 'R City Mall, Ghatkopar West, Mumbai',
    },
    {
      'id': 's4',
      'name': 'Nykaa Luxe',
      'image_url':
          'https://images.unsplash.com/photo-1522335789203-aaa687d6d18d?w=600',
      'rating': 4.9,
      'latitude': 19.0510,
      'longitude': 72.8330,
      'offer_label': 'FLAT 20% OFF',
      'category_id': 'beauty',
      'address': 'Palladium Mall, Lower Parel, Mumbai',
    },
    {
      'id': 's5',
      'name': 'H&M',
      'image_url':
          'https://images.unsplash.com/photo-1488161628813-04466f872be2?w=600',
      'rating': 4.2,
      'latitude': 19.0680,
      'longitude': 72.8330,
      'offer_label': 'FLAT ₹200',
      'category_id': 'fashion',
      'address': 'High Street Phoenix, Mumbai',
    },
    {
      'id': 's6',
      'name': 'Zara',
      'image_url':
          'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?w=600',
      'rating': 4.6,
      'latitude': 19.0540,
      'longitude': 72.8410,
      'offer_label': 'TRENDY',
      'category_id': 'fashion',
      'address': 'Atria Mall, Worli, Mumbai',
    },
    {
      'id': 's7',
      'name': 'Shoppers Stop',
      'image_url':
          'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=600',
      'rating': 4.3,
      'latitude': 19.0350,
      'longitude': 72.8400,
      'offer_label': 'VOUCHER',
      'category_id': 'fashion',
      'address': 'Inorbit Mall, Malad, Mumbai',
    },
    {
      'id': 's8',
      'name': 'BigBasket Express',
      'image_url':
          'https://images.unsplash.com/photo-1542838132-92c53300491e?w=600',
      'rating': 4.4,
      'latitude': 19.0830,
      'longitude': 72.8500,
      'offer_label': 'FREE DELIVERY',
      'category_id': 'grocery',
      'address': 'Khar West, Mumbai',
    },
  ];

  @override
  Future<List<StoreModel>> fetchNearbyStores({
    required double latitude,
    required double longitude,
    required String categoryId,
    required int page,
    required int pageSize,
  }) {
    return client.get<List<StoreModel>>(
      '/stores/nearby',
      query: {
        'lat': latitude,
        'lng': longitude,
        'category': categoryId,
        'page': page,
        'page_size': pageSize,
      },
      latency: const Duration(milliseconds: 600),
      body: () {
        Iterable<Map<String, dynamic>> filtered = _seedStores;
        if (categoryId != 'all') {
          filtered = filtered.where((e) => e['category_id'] == categoryId);
        }
        final list = filtered.toList();
        final start = (page - 1) * pageSize;
        if (start >= list.length) return <StoreModel>[];
        final end =
            (start + pageSize).clamp(0, list.length).toInt();
        return list.sublist(start, end).map(StoreModel.fromJson).toList();
      },
    );
  }
}
