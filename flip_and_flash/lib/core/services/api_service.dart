import 'package:dio/dio.dart';
import 'package:flip_and_flash/core/services/category_service.dart';
import 'package:flip_and_flash/core/services/deck_service.dart';
import 'package:flip_and_flash/core/services/flashcard_service.dart';
import 'package:talenty/config/config.dart';

class ApiService {
  ApiService._();

  static final String _baseUrl = Config.baseApiUrl;
  static Dio _client = Dio();

  static void init({required String firebaseIdToken}) {
    // Disposing old client
    _client.close();

    // Initializing new client
    _client = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        headers: _createHeaders(firebaseIdToken: firebaseIdToken),
      ),
    );
  }

  static Map<String, dynamic> _createHeaders(
      {required String firebaseIdToken}) {
    Map<String, String> headers = {};

    // Setting headers
    headers.putIfAbsent('Content-Type', () => 'application/json');
    headers.putIfAbsent('Accept', () => 'application/json');
    headers.putIfAbsent('Authorization', () => 'Bearer $firebaseIdToken');
    headers.putIfAbsent('Tenant-Id', () => Config.env.tenantId);

    return headers;
  }

  // Services
  static CategoryService get categories => CategoryService(_client);
  static DeckService get decks => DeckService(_client);
  static FlashcardService get flashcards => FlashcardService(_client);
}

extension ResponseStatus on Response {
  int get statusCodeNotNull => statusCode ?? 500;
  bool get isSuccessful => statusCodeNotNull >= 200 && statusCodeNotNull < 300;
}
