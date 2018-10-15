#!/bin/bash

if [ "$1" == "" ]; then
  echo
  echo "Uso: $0 wordlist.txt"
  echo
  exit
fi

dos2unix $1 >> /dev/null

for palavra in $(cat $1); do
  md5=" $(echo -n "$palavra" | md5sum | cut -d" " -f1)"
  base64="$(echo "$palavra" | base64)"
  sha256=$(echo "$palavra" | sha256sum | cut -d" " -f1)
  echo "$palavra:$md5:$base64:$sha256";

done > temp$1     # ou | column -s: -t >> "$1.final"

cat temp$1 | column -s: -t > "$1.final"
rm temp$1
