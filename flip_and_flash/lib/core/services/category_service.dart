import 'package:dio/dio.dart';
import 'package:flip_and_flash/core/models/category_model.dart';

@RestApi()
abstract class CategoryService {
  static const basePath = '/categories';

  factory CategoryService(Dio dio, {String baseUrl}) = _CategoryService;

  @GET(basePath)
  Future<List<Category>> getCategories();

  @POST(basePath)
  Future<List<Category>> getCategoriesByIds(
      @Body() GetCategoriesByIdsReq bodyReq);
}
