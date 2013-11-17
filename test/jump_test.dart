
library test;

import 'package:unittest/unittest.dart';
import 'package:jump/jump.dart';
import 'package:path/path.dart' as path;


Matcher output(String operation, String location, String name){
  String result;
  if (operation == 'list'){
    result = 'ls -l ~/.jumps | sed \'s/  / /g\' | cut -d\' \' -f9- | sed \'s/ -/\t-/g\'; and echo';
  }else if (operation == 'add'){
    result = 'mkdir -p ~/.jumps; ln -s $location ~/.jumps/$name;echo added $name to jump list';
  }else if (operation == 'remove'){
    result = 'rm ~/.jumps/$name;echo removed $name from jump list';
  }else{
    result = 'cd ~/.jumps/$name 2>/dev/null;'
        'or echo "No such jump point: $name"';
  }
  return equals(result);
}


main(){
  test('add', (){
    expect(
        generateCommand('add --location ~/ --name home'.split(' ')),
        output('add', '~/', 'home')
    );
    expect(
        generateCommand('add --location /home/defrex'.split(' ')),
        output('add', '/home/defrex', 'defrex')
    );
    expect(
        generateCommand('add'.split(' ')),
        output('add', path.current, path.basename(path.current))
    );
  });

  test('remove', (){
    expect(
        generateCommand('remove --location ~/ --name home'.split(' ')),
        output('remove', '~/', 'home')
    );
  });

  test('list', (){
    expect(
        generateCommand('list'.split(' ')),
        output('list', '~/', 'home')
    );
  });

  test('jump', (){
    expect(
        generateCommand('--location ~/ --name home'.split(' ')),
        output(null, '~/', 'home')
    );
  });

  test('help', (){
    expect(
        generateCommand('help'.split(' ')),
        contains('echo \'jump jump_name')
    );
  });
}
