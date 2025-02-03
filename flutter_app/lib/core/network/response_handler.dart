import 'exceptions.dart';

class ResponseHandler {
  static dynamic handleResponse(dynamic response) {
    if (response == null) {
      throw ApiException("Resposta nula do servidor");
    }
    return response;
  }
}
