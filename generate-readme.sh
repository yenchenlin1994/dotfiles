#!/bin/bash

set -x -e +H
cd "$(dirname "$0")"

cat>README.md<<EOF
# About
This repository contains configuration files I use on Mac and Linux systems
which have been inspired by the rest of the dotfiles community.
This \`README\` has been automatically generated by
[generate-readme.sh][generate-readme.sh] on $(date).
The following screenshots are automatically generated by
the [screenshots/generate.sh][screenshot-gen] script
by taking screenshots in an [X virtual framebuffer][xvfb].

[screenshot-gen]: https://github.com/bamos/dotfiles/blob/master/screenshots/generate.sh
[xvfb]: http://www.x.org/archive/X11R7.7/doc/man/man1/Xvfb.1.xhtml
[generate-readme.sh]: https://github.com/bamos/dotfiles/blob/master/generate-readme.sh
EOF

#./screenshots/generate.sh

SS_PREFIX=https://raw.githubusercontent.com/bamos/dotfiles/master/screenshots
for F in {vim,emacs,zsh,mutt,screen,tmux}; do
  echo -e "## $F\n![]($SS_PREFIX/$F.png)" >> README.md
done

cat>>README.md<<EOF
# Installation

Clone this repo with git's \`--recursive\` flag to obtain all the submodules.
Run [bootstrap.sh][bootstrap.sh] to symlink all of the dotfiles in this repo
to the home directory and install vim plugins.
This shell script will possibly be migrated to [GNU Stow][stow] in the future

[bootstrap.sh]: https://github.com/bamos/dotfiles/blob/master/bootstrap.sh
[stow]: http://www.gnu.org/software/stow/


# Shell functions and aliases.
The following is a summary of custom Bash and zsh functions and
aliases contained in [.funcs][funcs] and [.aliases][aliases].

[funcs]: https://github.com/bamos/dotfiles/blob/master/.funcs
[aliases]: https://github.com/bamos/dotfiles/blob/master/.aliases

## Functions
EOF

grep '()' .funcs | sed -e 's/\(.*\)().*/+ \1/g' >> README.md

cat>>README.md<<EOF

## Aliases
| Alias | Definition |
|---|---|
EOF
grep 'alias .*=' .funcs .aliases | \
  sed -e "s/.*alias \(.*\)=\(.*\)/\1 | \2/g" | \
  sort >> README.md

cat>>README.md<<EOF
# Similar Projects and Inspiration
There are many approaches to managing dotfiles on GitHub
that have inspired this repository, and this project
uniquely adds automatic screenshot generation.
The following list was generated on $(date +%Y-%m-%d) and
shows a subset of related projects.
[The dotfiles page on the Arch Linux Wiki](https://wiki.archlinux.org/index.php/Dotfiles)
is another good resource.

EOF

# Reference:
# https://github.com/bamos/python-scripts/blob/master/python3/github-repo-summary.py.
# Dependency: https://github.com/jacquev6/PyGithub

github-repo-summary.py \
  mathiasbynens/dotfiles \
  robbyrussell/oh-my-zsh \
  spf13/spf13-vim \
  tpope/tpope \
  justone/dotfiles \
  holman/dotfiles \
  gf3/dotfiles \
  joedicastro/dotfiles \
  ryanb/dotfiles \
  skwp/dotfiles \
  thoughtbot/dotfiles \
  cowboy/dotfiles \
  sontek/dotfiles \
  garybernhardt/dotfiles \
  paulmillr/dotfiles \
  rmm5t/dotfiles \
  ssaunier/dotfiles \
  windelicato/dotfiles \
  pengwynn/dotfiles \
  nelstrom/dotfiles \
  ocodo/.emacs.d \
  terhechte/emacs.d \
  themattman/dotfiles \
  themattman/utilities \
  vicfryzel/xmonad-config \
  >> README.md
