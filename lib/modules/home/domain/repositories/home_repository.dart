import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/ad_banner.dart';
import '../entities/category.dart';
import '../entities/reward.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Category>>> getCategories();
  Future<Either<Failure, List<AdBanner>>> getAdBanners();
  Future<Either<Failure, List<Reward>>> getWeeklyRewards();
}
