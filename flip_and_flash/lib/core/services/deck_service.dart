import 'package:dio/dio.dart';
import 'package:flip_and_flash/core/models/category_model.dart';

@RestApi()
abstract class DeckService {
  static const basePath = '/categories';

  factory DeckService(Dio dio, {String baseUrl}) = _DeckService;

  @GET(basePath)
  Future<List<Category>> getCategories();

  @POST(basePath)
  Future<List<Category>> getCategoriesByIds(
      @Body() GetCategoriesByIdsReq bodyReq);
}
