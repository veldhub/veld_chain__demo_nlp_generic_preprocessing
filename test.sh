#!/bin/bash

num_failed=0

function compare {
  echo "comparing: ${1} to correct hash: ${2}"
  md5_in_real=$(md5sum "$1" | awk '{print $1}')
  echo "real hash: ${md5_in_real}"
  if [[ "$md5_in_real" = "$2" ]]; then
    echo "result: correct" | tee -a test.log
  else
    echo "result: incorrect" | tee -a test.log
    ((num_failed++))
  fi
}


echo "--- test veld_demo_01__lowercase.yaml ---" | tee test.log

file_in=./data/demo_01/in/grimms_fairy_tales.txt
md5_in_correct=3b460a560a61b4e70e5ccc6f63c48063

file_out=./data/demo_01/out/grimms_fairy_tales__lowercased.txt
md5_out_correct=7d1efcc7a70e479d71405fe24a84e7ea
rm $file_out 2> /dev/null

file_out_metadata=./data/demo_01/out/veld__grimms_fairy_tales__lowercased.yaml
md5_out_metadata_correct=624fe00777dd3d260b714632afb121b5
rm $file_out_metadata 2> /dev/null

command="docker-compose -f veld_demo_01__lowercase.yaml up"
echo "executing: ${command}" | tee -a test.log
eval "$command" &>> test.log
echo "finished" | tee -a test.log

compare "$file_in" "$md5_in_correct"
compare "$file_out" "$md5_out_correct"
compare "$file_out_metadata" "$md5_out_metadata_correct"


echo "--- test veld_demo_02__clean.yaml ---" | tee test.log

file_in=./data/demo_02/in/grimms_fairy_tales.txt
md5_in_correct=3b460a560a61b4e70e5ccc6f63c48063

file_out_clean=./data/demo_02/out/grimms_fairy_tales__clean.txt
md5_out_clean_correct=c55240515498f45c912bbcfbc313f339
rm $file_out_clean 2> /dev/null

file_out_dirty=./data/demo_02/out/grimms_fairy_tales__dirty.txt
md5_out_dirty_correct=074bdd74e5bc95b6023dd7040bb61320
rm $file_out_dirty 2> /dev/null

file_out_metadata=./data/demo_02/out/veld__grimms_fairy_tales__clean.yaml
md5_out_metadata_correct=b70c028a520f5e27d1f76849e7569aaf
rm $file_out_metadata 2> /dev/null

command="docker-compose -f veld_demo_02__clean.yaml up"
echo "executing: ${command}" | tee -a test.log
eval "$command" &>> test.log
echo "finished" | tee -a test.log

compare "$file_in" "$md5_in_correct"
compare "$file_out_clean" "$md5_out_clean_correct"
compare "$file_out_dirty" "$md5_out_dirty_correct"
compare "$file_out_metadata" "$md5_out_metadata_correct"


echo "--- test veld_demo_03_regex_replace.yaml ---" | tee test.log

file_in=./data/demo_03/in/grimms_fairy_tales.txt
md5_in_correct=3b460a560a61b4e70e5ccc6f63c48063

file_out=./data/demo_03/out/grimms_fairy_tales__newline_removed.txt
md5_out_correct=e696a7fd33f597f1a7f2315fb271e5a1
rm $file_out_clean 2> /dev/null

file_out_metadata=./data/demo_03/out/veld__grimms_fairy_tales__newline_removed.yaml
md5_out_metadata_correct=863fb5cfef112bbd9cb209fe612e540b
rm $file_out_metadata 2> /dev/null

command="docker-compose -f veld_demo_03_regex_replace.yaml up"
echo "executing: ${command}" | tee -a test.log
eval "$command" &>> test.log
echo "finished" | tee -a test.log

compare "$file_in" "$md5_in_correct"
compare "$file_out" "$md5_out_correct"
compare "$file_out_metadata" "$md5_out_metadata_correct"


echo "--- all tests executed ---"
echo "number of failed tests: ${num_failed}"

