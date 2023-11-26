#!/bin/bash
set -exu pipefail

cd
git clone https://github.com/sergsoares/.dotfiles
cd .dotfiles
make install
