#!/bin/bash
find $1 -type f -name "en.yml" -print |grep locales |grep -v build |grep -v plugins
rm -f all_ymls.yml

for i in $(find $1 -type f -name "en.yml" -print | \
  grep locales |grep -v build |grep -v plugins);do \
  echo -e; echo '#=======>'$i; echo -e; cat $i ;done >> all_ymls.yml
