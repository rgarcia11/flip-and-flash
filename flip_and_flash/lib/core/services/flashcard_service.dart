import 'package:dio/dio.dart';
import 'package:flip_and_flash/core/models/category_model.dart';

@RestApi()
abstract class FlashcardService {
  static const basePath = '/categories';

  factory FlashcardService(Dio dio, {String baseUrl}) = _FlashcardService;

  @GET(basePath)
  Future<List<Category>> getCategories();

  @POST(basePath)
  Future<List<Category>> getCategoriesByIds(
      @Body() GetCategoriesByIdsReq bodyReq);
}
