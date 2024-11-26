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
