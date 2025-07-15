import 'package:flutter_demo_3_32_5/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group('Test start, increment, decrement', (){
    test('value should start at 0', (){
      final counter = Counter();
      
      expect(counter.value, 0);
    });
    
    test('counter should be decrease', (){
      final counter = Counter();

      counter.decrease();

      expect(counter.value, -1);
    });

    test('counter should be increase', (){

      final counter = Counter();
      counter.increase();

      expect(counter.value, 1);
    });

  });
}