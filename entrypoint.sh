#!/bin/bash

# Build
# ----------------------------
ERROR_OPTIONS="\
  -halt-on-error \
  -interaction=nonstopmode \
  -file-line-error \
"

root=$(pwd)
src=$root/$LATEX_BASEDIR
main=$src/$LATEX_MAIN_FILENAME
bib=$src/$BIBTEX_FILENAME
images=$src/$IMAGE_DIR
output=$root/$LATEX_OUTPUT_DIR

compile () {
  # $1 $ERROR_OPTIONS -output-directory=$output $main.tex
  $1 $ERROR_OPTIONS $main.tex
}

if [ "pdflatex" = $LATEX_ENGINE ]; then
  compile $LATEX_ENGINE
  bibtex ./$LATEX_MAIN_FILENAME
  compile $LATEX_ENGINE
  compile $LATEX_ENGINE

  # if [ -e $BIBTEX_FILENAME.bib ]; then
  #   # bibtex $output/$LATEX_MAIN_FILENAME
  #   bibtex $root/$LATEX_MAIN_FILENAME
  # fi

  # if [ -n "$(ln $images)" ]; then
  #   compile $LATEX_ENGINE
  #   compile $LATEX_ENGINE
  # fi
fi

if [ ! -e $output ]; then
  mkdir -p $output
fi

mv $LATEX_MAIN_FILENAME.* $output

# Git add commit push
git config user.name github-actions
git config user.email github-actions@github.com
git add ./build/main.tex
git commit -m " generated"
git push
