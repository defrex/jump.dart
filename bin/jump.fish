
set DART_JUMP ~/code/jump

function jump
  eval (eval $DART_JUMP/bin/jump.dart $argv)
end

function jp;jump $argv;end
