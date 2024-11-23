import 'package:http/http.dart';

import '../common/api_resource.dart';

abstract class ApiServiceProtocol {
  Future<Response> sendGetRequest(
    ApiResource resource,
    Map<String, String> parameters,
  );
}

class ApiService implements ApiServiceProtocol {
  @override
  Future<Response> sendGetRequest(
    ApiResource resource,
    Map<String, String> parameters,
  ) async {
    final url = _formatUrl(resource, parameters);
    return await get(Uri.parse(url));
  }

  String _formatUrl(
    ApiResource resource,
    Map<String, String> parameters,
  ) {
    final url = Uri.http(resource.baseUrl, resource.name, parameters);
    return url.toString();
  }
}

// Service Mock
// class MockApiService implements ApiServiceProtocol {
//   @override
//   Future<Response> sendGetRequest(String url) async {
//     // Return a fake HTTP response
//     return Response(
//       '[{"timestamp": "2024-10-20T00:00:00.000Z", "value": 1234}]',
//       200,
//     );
//   }
// }

// extension MockExtension on ApiService {
//   static ApiServiceProtocol get mock => MockApiService();
// }
