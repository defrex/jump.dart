
library test;

import 'package:unittest/unittest.dart';
import 'jump.dart' as jump;


String output(String operation, String location, String name){
  if (operation == 'list'){
    return 'ls -l "~/.jumps" | sed \'s/  / /g\' | cut -d\' \' -f9- | sed \'s/ -/\t-/g\'; and echo';
  }else if (operation == 'add'){
    return 'mkdir -p "~/.jumps"; ln -s ($location) "~/.jumps/$name";echo added $name to jump list';
  }else if (operation == 'remove'){
    return 'rm ~/.jumps/$location;echo removed $name from jump list';
  }
}


main(){
  expect(
      jump.generateCommand('add --location ~/ --name home'.split(' ')),
      output('add', '~/', 'home')
  );
  expect(
      jump.generateCommand('remove --location ~/ --name home'.split(' ')),
      output('remove', '~/', 'home')
  );
  expect(
      jump.generateCommand('list'.split(' ')),
      output('list', '~/', 'home')
  );
  expect(
      jump.generateCommand('--location ~/ --name home'.split(' ')),
      output('add', '~/', 'home')
  );
}
