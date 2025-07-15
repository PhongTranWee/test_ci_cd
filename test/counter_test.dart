import 'package:flutter_demo_3_32_5/counter.dart';
import 'package:test/test.dart';

void main(){
  test('Counter should be increase', (){
    final counter = Counter();

    counter.increase();

    expect(counter.value, 1);
  });
}