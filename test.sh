#!/bin/bash

test_log="test.log"
rm "$test_log" 2> /dev/null

num_failed=0

function compare {
  echo "comparing: ${1} to correct hash: ${2}"
  md5_in_real=$(md5sum "$1" | awk '{print $1}')
  echo "real hash: ${md5_in_real}"
  if [[ "$md5_in_real" = "$2" ]]; then
    echo "result: correct" | tee -a "$test_log"
  else
    echo "result: incorrect" | tee -a "$test_log"
    ((num_failed++))
  fi
}


function execute {
  file_in="$1"
  md5_in_correct="$2"
  file_out="$3"
  md5_out_correct="$4"
  compose_command="$5"

  rm "$file_out" 2> /dev/null

  echo "- test ${compose_command} -------------------------------------" | tee -a "$test_log"

  echo "executing: ${compose_command}" | tee -a "$test_log"
  eval "$compose_command" &>> "$test_log"
  echo "finished" | tee -a "$test_log"

  compare "$file_in" "$md5_in_correct"
  compare "$file_out" "$md5_out_correct"
}


execute \
  ./data/demo_0/grimms_fairy_tales.txt \
  bd2bb71a469af6b3fa63434e466ca216 \
  ./data/demo_1/grimms_fairy_tales.txt \
  3238c7fc75e190bc2e71e5debbfa36e0 \
  "docker-compose -f veld_demo_1_regex_replace.yaml up"

execute \
  ./data/demo_1/grimms_fairy_tales.txt \
  3238c7fc75e190bc2e71e5debbfa36e0 \
  ./data/demo_2/grimms_fairy_tales.txt \
  1fb1783973690b624e8ae5a5c436d97d \
  "docker-compose -f veld_demo_2_split_sentences.yaml up"

execute \
  ./data/demo_2/grimms_fairy_tales.txt \
  1fb1783973690b624e8ae5a5c436d97d \
  ./data/demo_3/grimms_fairy_tales.txt \
  4b8b2d0c5b6083f9b78f1c784eefc2c6 \
  "docker-compose -f veld_demo_3_clean.yaml up"

execute \
  ./data/demo_3/grimms_fairy_tales.txt \
  4b8b2d0c5b6083f9b78f1c784eefc2c6 \
  ./data/demo_4/grimms_fairy_tales.txt \
  e32a4771f6277f86981a364b530d8259 \
  "docker-compose -f veld_demo_4_lemmatize.yaml up"

execute \
  ./data/demo_4/grimms_fairy_tales.txt \
  e32a4771f6277f86981a364b530d8259 \
  ./data/demo_5/grimms_fairy_tales.txt \
  9e2a0a79ea39afcd7539162a0105504b \
  "docker-compose -f veld_demo_5_remove_punctuation.yaml up"

execute \
  ./data/demo_5/grimms_fairy_tales.txt \
  9e2a0a79ea39afcd7539162a0105504b \
  ./data/demo_6/grimms_fairy_tales.txt \
  d02052ada8e22becb9ee722becbe674b \
  "docker-compose -f veld_demo_6_remove_whitespace.yaml up"

execute \
  ./data/demo_6/grimms_fairy_tales.txt \
  d02052ada8e22becb9ee722becbe674b \
  ./data/demo_7/grimms_fairy_tales.txt \
  2eaeafff6181f9bd540643aca3d67fe5 \
  "docker-compose -f veld_demo_7_change_case.yaml up"

execute \
  ./data/demo_7/grimms_fairy_tales.txt \
  2eaeafff6181f9bd540643aca3d67fe5 \
  ./data/demo_8/grimms_fairy_tales.txt \
  4662eef3c229e2e4c69a1ac508b3614b \
  "docker-compose -f veld_demo_8_sample.yaml up"


echo "--- all tests executed ---"
echo "number of failed tests: ${num_failed}"

