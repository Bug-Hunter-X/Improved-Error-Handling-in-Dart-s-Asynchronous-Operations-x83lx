```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
  @override
  String toString() => message;
}

class DataParseException implements Exception {
  final String message;
  DataParseException(this.message);
  @override
  String toString() => message;
}

Future<Map<String, dynamic>?> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://example.com/data'));
    if (response.statusCode == 200) {
      try {
        final jsonData = jsonDecode(response.body);
        return jsonData;
      } on FormatException {
        throw DataParseException('Invalid JSON format');
      }
    } else {
      throw NetworkException('Failed to load data: ${response.statusCode}');
    }
  } on http.ClientException catch (e) {
    throw NetworkException('Network request failed: $e');
  } catch (e) {
    print('Unexpected Error: $e');
    rethrow; //Rethrow to the caller for more specific error handling
  }
}

void main() async {
  try {
    final data = await fetchData();
    print(data);
  } on NetworkException catch (e) {
    print('Network error: ${e}');
  } on DataParseException catch (e) {
    print('Data parsing error: ${e}');
  } catch (e) {
    print('An unexpected error occurred: $e');
  }
}
```