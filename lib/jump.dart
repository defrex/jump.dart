
library jump;

import 'package:args/args.dart';
import 'package:path/path.dart' as path;


final String JUMP_PATH = path.normalize('~/.jumps');


String generateCommand(List<String> arguments){
  var parser = new ArgParser();

  parser.addOption(
      'name',
      abbr: 'n',
      help: 'Specify the jump name (defaults to directory basename)',
      defaultsTo: null
  );

  parser.addOption(
      'location',
      abbr: 'l',
      help: 'Specify the jump directory',
      defaultsTo: path.current
  );

  parser.addCommand('add');
  parser.addCommand('remove');
  parser.addCommand('list');
  parser.addCommand('help');

  var args = parser.parse(arguments);
  var jump_name = args['name'];
  var jump_directory = args['location'];

  if (jump_name == null && args.rest.length == 0){
    jump_name = path.basename(jump_directory);
  }else if (jump_name == null && args.rest.length > 0){
    jump_name = args.rest[0];
  }

  if(args.command == null){
    return 'cd $JUMP_PATH/$jump_name 2>/dev/null;'
    'or echo "No such jump point: $jump_name"';

  }else if (args.command.name == 'add'){
    return 'mkdir -p $JUMP_PATH; ln -s $jump_directory $JUMP_PATH/$jump_name;'
      'echo added $jump_name to jump list';

  }else if (args.command.name == 'remove'){
    return 'rm $JUMP_PATH/$jump_name;'
      'echo removed $jump_name from jump list';

  }else if (args.command.name == 'list'){
    return 'ls -l $JUMP_PATH | sed \'s/  / /g\' | cut -d\' \' -f9- | sed \'s/ -/\t-/g\'; and echo';

  }else if (args.command.name == 'help'){
    return '''
echo jump jump_name  - Go to a jump point
echo jump command  - Manage jump points
echo
echo commands: add, remove, list, help
echo
echo -l, --location    Specify the jump directory (defaults to current directory)
echo -n, --name        Specify the jump name (defaults to location basename)
''';
  }
}
