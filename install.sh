#!/bin/sh

for name  in dot/* ; do
  target="$HOME/.`basename $name`"
  if [ -e "$target" ]; then
    if [ ! -L "$target" ]; then
      echo "WARNING: $target exists but is not a symlink."
      echo "Backuping file $target to $(target)_old"
      mv $target "$(target)_old"
    fi
  else
    echo "Creating $target"
    ln -s "$PWD/$name" "$target"
  fi
done

vundle_dir=~/.vim/bundle/vundle
echo "Checking for vundle: "
if [ -e vundle_dir ]; then
  echo "Vundle was not found cloning it"
  git clone https://github.com/gmarik/vundle.git  $vundle_dir
else
  echo vundle already in place
fi

vim -u ~/.vimrc.bundles +BundleInstall +qa
