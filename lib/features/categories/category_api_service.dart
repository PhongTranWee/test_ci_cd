import 'dart:convert';
import 'package:http/http.dart' as http;
import 'category_model.dart'; // Đảm bảo import đúng đường dẫn

class CategoryApiService {
  final http.Client client;
  final String baseUrl = 'https://api.example.com'; // Thay thế bằng URL API thực tế nếu có

  CategoryApiService({required this.client});

  Future<List<Category>> fetchCategories() async {
    try{
      final uri = Uri.parse('$baseUrl/categories'); // Giả sử endpoint là /categories
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    }catch(e){
      throw Exception('json error');
    }
  }
}