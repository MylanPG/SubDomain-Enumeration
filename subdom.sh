#!/usr/bin/bash

while getopts ":s:w:o:*:" opt; do
case $opt in

s)
dom=$OPTARG>&2
;;
w)
list=$OPTARG>&2
;;
o)
out=$OPTARG>&2
;;

*)
  echo "-s: enter doman name. Exclude https:// "
  echo "-w: enter wordlist"
  echo "-o: enter output file"
  exit
;;


esac

done

[ -z "$list" ]  && echo "-w is mandatory. see -h for help"
[ -z "$dom" ] && echo "-s is mandatory. see -h for help"

[ -z "$list" ] || [ -z "$dom" ] && exit 1

  while IFS= read -r line; do
  a="https://$line.$dom"
  w="$list"
  if curl -i -s $a | grep -q "HTTP/2 200"
   then
     echo "$line, OK"
     [ -z "$out" ] || echo "$a" >> $out
  else
     echo "$line, $a, Not OK"
   fi
 done < "$list"
