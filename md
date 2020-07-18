#!/bin/sh
# md - shortcut for makedir < dirName >
# first arg is the dirName

args=("$@")

mkdir "${args[0]}"