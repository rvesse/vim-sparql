#!/bin/sh

# Installs the plugin into the users .vim directory
cp -v syntax/*.vim ~/.vim/syntax/
cp -v ftdetect/*.vim ~/.vim/ftdetect/

echo "Vim SPARQL plugin installed"