import 'package:flutter_demo_3_32_5/main_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_album_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])

void main(){
  late MockClient mockClient;

  setUp((){
    mockClient = MockClient();
  });

  test('test fetchAlbum all successfully', ()async{
    when(mockClient.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'))).thenAnswer((realInvocation) {
      return Future.value(http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));
    },);

    final result = await fetchAlbum(mockClient);

    expect(result, isA<Album>());

    verify(mockClient.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'))).called(1);
  });

  test('test fetchAlbum not found', ()async{
    when(mockClient.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'))).thenThrow(Exception('Failed to load album'));

    expect(fetchAlbum(mockClient), throwsException);
  });
}
/*

void main() {
  group('fetchAlbum', () {
    test('returns an Album if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(
        client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')),
      ).thenAnswer(
            (_) async =>
            http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200),
      );

      expect(await fetchAlbum(client), isA<Album>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(
        client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')),
      ).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchAlbum(client), throwsException);
    });
  });
}
*/
