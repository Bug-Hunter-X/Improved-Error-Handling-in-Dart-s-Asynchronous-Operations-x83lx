```dart
Future<void> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://example.com/data'));
    if (response.statusCode == 200) {
      // Success! Parse the JSON response
      final jsonData = jsonDecode(response.body);
      // Process jsonData here
    } else {
      // Handle error
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    // Handle exceptions during network request or JSON parsing
    print('Error fetching data: $e');
    // Consider rethrowing the exception or handling it appropriately based on your app's needs.
    rethrow; // Rethrow to allow the calling function to handle the error
  }
}
```