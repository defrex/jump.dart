
library test;

import 'package:unittest/unittest.dart';
import 'package:jump/jump.dart';
import 'package:path/path.dart' as path;


String output(String operation, String location, String name){
  if (operation == 'list'){
    return 'ls -l "~/.jumps" | sed \'s/  / /g\' | cut -d\' \' -f9- | sed \'s/ -/\t-/g\'; and echo';
  }else if (operation == 'add'){
    return 'mkdir -p "~/.jumps"; ln -s ($location) "~/.jumps/$name";echo added $name to jump list';
  }else if (operation == 'remove'){
    return 'rm ~/.jumps/$location;echo removed $name from jump list';
  }else{
    return 'cd "~/.jumps/$name" 2>/dev/null;'
        'or echo "No such jump point: $name"';
  }
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
}
