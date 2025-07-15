
import 'package:flutter_demo_3_32_5/features/categories/category_api_service.dart';
import 'package:flutter_demo_3_32_5/features/categories/category_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'category_api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main(){
  late MockClient mockClient;
  late CategoryApiService categoryApiService;
  final uri = Uri.parse('https://api.example.com/categories');

  setUp((){
    mockClient = MockClient();
    categoryApiService = CategoryApiService(client: mockClient);
  });

  // test case 1: fetchCategories successfully with status code 200
  test('test fetchCategories successfully', ()async{
    when(mockClient.get(uri)).thenAnswer((_) {
      return Future.value(http.Response('[{"id" : 1, "name" : "Cate1"}, {"id" : 2, "name" : "Cate2"}]', 200));
    });

    final result = await categoryApiService.fetchCategories();

    expect(result, isA<List<Category>>());
    expect(result.length, 2);
    expect(result[0].name, 'Cate1');
    expect(result[1].name, 'Cate2');

    verify(mockClient.get(uri)).called(1);
  });

  // test case 2: fetchCategories failed with status code != 200
  test('fetchCategories Failed to load categories ', ()async{
    when(mockClient.get(uri)).thenThrow(Exception('Failed to load categories'));

    expect(categoryApiService.fetchCategories(), throwsException);

    verify(mockClient.get(uri)).called(1);

    verifyNoMoreInteractions(mockClient);
  });

  // test case 3: invalid json format
  test('fetchCategories invalid json format', ()async{
    when(mockClient.get(uri)).thenAnswer((realInvocation) {
      return Future.value(http.Response(
        '{"error": "invalid format"}', 200,
      ));
    },);

    // final result = await categoryApiService.fetchCategories();

    expect(
          () async => await categoryApiService.fetchCategories(),
      throwsA(isA<Exception>()),
    );
    // expect(await categoryApiService.fetchCategories(), throwsA(isA<FormatException>()));

    verify(mockClient.get(uri)).called(1);
  });

  // test case 4: Internet error
  test('fetchCategories Internet error', ()async{
    when(mockClient.get(uri)).thenThrow(http.ClientException('No internet connection'));

    expect(
          () async => await categoryApiService.fetchCategories(),
      throwsA(isA<Exception>()), // Hoặc isA<Exception>() nếu bạn muốn bắt chung
    );

    verify(mockClient.get(uri)).called(1);
    verifyNoMoreInteractions(mockClient);
  });

  // test case 5: empty list

  test('fetchCategories empty list', ()async{
    when(mockClient.get(uri)).thenAnswer((_)=> Future.value(http.Response('[]', 200)));

    final result = await categoryApiService.fetchCategories();

    expect(result, isA<List<Category>>());
    expect(result, isEmpty);

    verify(mockClient.get(uri)).called(1);

    verifyNoMoreInteractions(mockClient);
  });
}