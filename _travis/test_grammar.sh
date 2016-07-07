#!/bin/bash

errors=0
for f in $(find _site -name '*.html' -not -name '*.amp.html'); do
  echo -n "checking grammar in $f... "
  tidy -i -asxml $f 2>/dev/null | \
    sed "s|>|>\n|g" | \
    xmllint -html -xpath '(//article//p|//article//h2|//article//h3|//article//h4)/text()' - 2>/dev/null | \
    sed "s/[^a-zA-Z'@\"\-]/ /g" | \
    sed 's/[ \t\n]/\n/g' | \
    LC_ALL='C' sort | \
    uniq | \
    aspell --ignore=3 -p ./_travis/aspell.en.pws pipe | \
    grep '^&'
  if [ $? -ne 1 ]; then
    ((errors++))
  else
    echo "OK"
  fi
done
if [ $errors -ne 0 ]; then
  echo "there are ${errors} problems above"
  exit -1
fi

errors=0
for f in $(find . -regex '\./_site/[0-9]\{4\}/.*\.html' -not -name '*.amp.html'); do
  echo -n "checking name of $f... "
  echo $f | sed "s|[^a-zA-Z]| |g" | \
    LC_ALL='C' sort | \
    aspell --lang=en_US --ignore=2 --ignore-case -p ./_travis/aspell.en.pws pipe | \
    grep ^\&
  if [ $? -ne 1 ]; then
    ((errors++))
  else
    echo "OK"
  fi
done
if [ $errors -ne 0 ]; then
  echo "there are ${errors} problems above"
  exit -1
fi

echo "grammar is clean!"
