#!/bin/sh

# Create necessary vim directories if they don't already exist
mkdir -p ~/.vim/syntax/ ~/.vim/ftdetect/ 

# Installs the plugin into the users .vim directory
cp -v syntax/*.vim ~/.vim/syntax/
cp -v ftdetect/*.vim ~/.vim/ftdetect/

echo "Vim SPARQL plugin installed"
