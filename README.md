### Jump

This is a little script I use to navigate between project directories with ease. It's implemented in [Dart](https://dartlang.org) to give me an excuse to try out the language on something small. Formerly it was all [Fish](http://fishshell.com).

#### Usage

    jump jump_name  - Go to a jump point
    jump command    - Manage jump points

    commands: add, remove, list, help

    -l, --location  Specify the jump directory (defaults to current directory)
    -n, --name  Specify the jump name (defaults to location basename)
