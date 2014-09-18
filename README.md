# VIM-SPARQL

This is an fork of a script originally uploaded to [http://www.vim.org/scripts/script.php?script_id=1755](http://www.vim.org/scripts/script.php?script_id=1755).  It has been significantly upgraded to support SPARQL 1.1

## Features

- Highlights most of SPARQL 1.1 Query and Update Syntax
- Folding support for `{ }`, `[ ]` and `( )`
- Rainbow parenthesis support (Requires [optional dependencies](#optional-dependencies)

### TODO

The following features are not yet implemented:

- Highlighting SPARQL 1.1 Prefixed Names
- Highlighting blank nodes
- Highlighting data type and language specifiers
- Highlighting invalid literal forms as warnings

## Installation

Either copy all the sub-folders to your `~/.vim` directory manually or you can run the provided `install.sh` script to do this for you:

    > ./install.sh
    syntax/sparql.vim -> /Users/rvesse/.vim/syntax/sparql.vim
    ftdetect/sparql.vim -> /Users/rvesse/.vim/ftdetect/sparql.vim
    Vim SPARQL plugin installed

### Dependencies

The plugin requires Vim 6 or higher.

#### Optional Dependencies

The plugin can use the following plugins if they are installed and enabled:

- Rainbow Parenthesis - In order of preference
    1. [Rainbow Improved](https://github.com/oblitum/rainbow)
        - Currently there is a bug which may break this plugin, see [pull request](https://github.com/oblitum/rainbow/pull/13) which fixes it
    1. [Rainbow Parenthsis](http://www.vim.org/scripts/script.php?script_id=1561)
        - No folding support in this plugin

## License

The SPARQL Vim Plugin is in the public domain under the Unlicense, see the `LICENSE` file in this repository

## Acknowledgements

Original script by Jeroen Pulles, 2007-01-07

Filetype detection added by Omer Jakobinsky in his fork at https://github.com/Omer/vim-sparql

SPARQL 1.1, folding and rainbow parenthesis support added by Rob Vesse
